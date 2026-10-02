import {NextResponse} from "next/server";

export const dynamic = "force-dynamic";
export const revalidate = 0;

export async function GET() {
  const response = await fetch(
    "https://api.github.com/repos/Narsing-s/sql-from-zero-to-advanced/git/trees/main?recursive=1",
    {
      headers: {
        Accept: "application/vnd.github+json",
        "User-Agent": "sql-from-zero-to-advanced-ui",
      },
      next: {revalidate: 300},
    },
  );

  if (!response.ok) {
    return NextResponse.json(
      {error: "Unable to load the repository tree", files: []},
      {status: 502},
    );
  }

  const tree = await response.json();
  const files = (tree.tree ?? [])
    .filter((item: {type?: string; path?: string}) => item.type === "blob" && item.path)
    .map((item: {path: string; size?: number}) => ({
      path: item.path,
      size: item.size ?? 0,
      type: "file",
    }))
    .sort((a: {path: string}, b: {path: string}) => a.path.localeCompare(b.path));

  return NextResponse.json(
    {branch: "main", truncated: Boolean(tree.truncated), files},
    {headers: {"Cache-Control": "public, max-age=300, s-maxage=300"}},
  );
}
