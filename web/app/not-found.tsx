import Link from "next/link";

export default function NotFound() {
  return (
    <main className="shell">
      <div className="container">
        <section className="card" style={{maxWidth:720,margin:"80px auto"}}>
          <div className="eyebrow">404 · SQL Learning Hub</div>
          <h1>Lesson not found.</h1>
          <p className="muted">The requested learning page does not exist.</p>
          <Link className="btn primary" href="/">Back to curriculum</Link>
        </section>
      </div>
    </main>
  );
}