import "./globals.css";
export const metadata = {
  title: "SQL From Zero to Advanced",
  description: "A practical, open SQL learning hub from installation to production engineering."
};
export default function RootLayout({children}:{children:React.ReactNode}) {
  return <html lang="en" className="dark"><body>{children}</body></html>;
}
