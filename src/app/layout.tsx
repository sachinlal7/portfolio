import type { Metadata } from "next";
import "./globals.css";

export const metadata: Metadata = {
  title: "Sachin Lal | Cyberpunk Flutter Portfolio",
  description:
    "Single-page cyberpunk portfolio for Sachin Lal, a Flutter developer focused on mobile apps, rewards platforms, API integrations, and production-ready delivery.",
};

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html lang="en" className="h-full scroll-smooth antialiased">
      <body className="min-h-full">{children}</body>
    </html>
  );
}
