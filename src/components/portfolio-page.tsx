"use client";

import type {
  ChangeEvent,
  CSSProperties,
  FormEvent,
  MouseEvent,
  ReactNode,
  SVGProps,
} from "react";
import Image from "next/image";
import { AnimatePresence, motion, type Transition } from "motion/react";
import { useEffect, useRef, useState } from "react";

type GlowColor = "cyan" | "purple" | "pink" | "none";

type IconProps = SVGProps<SVGSVGElement>;

type SectionId = "home" | "about" | "skills" | "projects" | "contact";

type TiltSettings = {
  max: number;
  scale: number;
  speed: number;
  maxGlare: number;
};

type Particle = {
  left: string;
  top: string;
  delay: string;
  duration: string;
  size: number;
};

type SkillCategory = {
  title: string;
  color: Exclude<GlowColor, "none">;
  icon: (props: IconProps) => ReactNode;
  skills: string[];
};

type Project = {
  title: string;
  image: string;
  description: string;
  tags: string[];
  github: string;
  live: string;
};

type SocialLink = {
  label: string;
  href: string;
  handle: string;
  color: Exclude<GlowColor, "none">;
  icon: (props: IconProps) => ReactNode;
};

const typedTitle = "Flutter Developer";

const sectionTransition: Transition = { duration: 0.5, ease: "easeOut" };

const navItems: Array<{ label: string; id: SectionId }> = [
  { label: "About", id: "about" },
  { label: "Skills", id: "skills" },
  { label: "Projects", id: "projects" },
  { label: "Contact", id: "contact" },
];

const infoItems = [
  {
    icon: UserIcon,
    color: "text-primary",
    value: "Sachin Lal",
  },
  {
    icon: BriefcaseIcon,
    color: "text-secondary",
    value: "Flutter Developer",
  },
  {
    icon: MapPinIcon,
    color: "text-accent",
    value: "India",
  },
  {
    icon: MailIcon,
    color: "text-primary",
    value: "Sachinlal138@gmail.com",
  },
];

const skillCategories: SkillCategory[] = [
  {
    title: "Languages & Core",
    color: "cyan",
    icon: PaletteIcon,
    skills: ["Flutter", "Dart", "C Language", "HTML", "CSS"],
  },
  {
    title: "State & Architecture",
    color: "purple",
    icon: ServerIcon,
    skills: ["GetX", "BLoC", "MVC", "Clean Architecture", "Responsive Design"],
  },
  {
    title: "APIs & Services",
    color: "pink",
    icon: DatabaseIcon,
    skills: [
      "REST APIs",
      "Firebase",
      "Google Maps",
      "Push Notifications",
      "Zegocloud",
    ],
  },
  {
    title: "Versioning & Data",
    color: "cyan",
    icon: CpuIcon,
    skills: ["Git", "Github", "CodeCommit", "Bitbucket", "MySql"],
  },
  {
    title: "Workflow & Tools",
    color: "purple",
    icon: CodeIcon,
    skills: ["Jira", "Postman", "VS Code", "Android Studio", "Bootstrap"],
  },
];

const projects: Project[] = [
  {
    title: "Uchaguzi",
    image:
      "https://play-lh.googleusercontent.com/A8m8IlcNkjXe7A1Zu_xr4qV-E7n08K4cAHNfi4A7BuZ0O5O454hRntm7v77bV3rQz-gZZY4FD9e4ojClo3O3vw=w832-h470-rw",
    description:
      "A Kenya-based multi-role Flutter app for politicians, citizens, and suppliers supporting election operations, civic engagement, communication, fundraising, wallet services, and marketplace workflows.",
    tags: ["Flutter","BLoC", "Geofencing", "OCR", "Live Streaming", "Voice Call" ,"Video Call"],
    github: "https://github.com/sachinlal7",
    live: "https://play.google.com/store/apps/details?id=com.app.uchaguzi&hl=en_IN ",
  },
  {
    title: "Shubh Mangal",
    image: "/images/shubh-mangal-banner.png",
    description:
      "A role-based loyalty platform for KRBL rice retailers and field users supporting dual campaigns, reward redemption, points tracking, OTP login, and KYC verification.",
    tags: ["Flutter", "BLoC", "REST APIs", "Rewards"],
    github: "https://github.com/sachinlal7",
    live: "https://play.google.com/store/apps/details?id=com.almonds.krbl&hl=en_IN",
  },
  {
    title: "BirlaNu Rewards App",
    image: "/images/birla-nu-banner.png",
    description:
      "A role-based rewards and benefits platform for tile masons, painters, plumbers, retailers, and distributors with KYC, QR voucher redemption, passbook tracking, and enquiries.",
    tags: ["Flutter", "GetX", "QR", "Passbook"],
    github: "https://github.com/sachinlal7",
    live: "https://play.google.com/store/apps/details?id=com.almonds.hil&hl=en_IN",
  },
  {
    title: "Pepsico Loyalty App",
    image:
      "https://play-lh.googleusercontent.com/A5jBXDmaAipCRCm2NgsLpPdrq_MKI44KkJNDBBwaark7rlZkE-kzPybrFSAhjriRksbq=w832-h470-rw",
    description:
      "A loyalty app for tracking user activities and managing rewards, built with secure tracking, API data integration, and authentication for protected user transactions.",
    tags: ["Flutter", "Rewards", "Authentication", "APIs"],
    github: "https://github.com/sachinlal7",
    live: "https://play.google.com/store/apps/details?id=com.almond.pepsicoapp&hl=en_IN",
  },
];

const socialLinks: SocialLink[] = [
  {
    label: "GitHub",
    href: "https://github.com/sachinlal7",
    handle: "github.com/sachinlal7",
    color: "cyan",
    icon: GitHubIcon,
  },
  {
    label: "LinkedIn",
    href: "https://www.linkedin.com/in/sachinlal7/",
    handle: "linkedin.com/in/sachinlal7",
    color: "purple",
    icon: LinkedinIcon,
  },
  {
    label: "HackerRank",
    href: "https://www.hackerrank.com/profile/sachinlal138",
    handle: "hackerrank.com/profile/sachinlal138",
    color: "pink",
    icon: Code2Icon,
  },
];

const skillTilt: TiltSettings = {
  max: 15,
  scale: 1.02,
  speed: 400,
  maxGlare: 0.2,
};

const projectTilt: TiltSettings = {
  max: 10,
  scale: 1.01,
  speed: 300,
  maxGlare: 0.15,
};

function cn(...parts: Array<string | false | null | undefined>) {
  return parts.filter(Boolean).join(" ");
}

function iconBase(children: ReactNode, props: IconProps, className?: string) {
  return (
    <svg
      viewBox="0 0 24 24"
      fill="none"
      stroke="currentColor"
      strokeWidth="1.8"
      strokeLinecap="round"
      strokeLinejoin="round"
      aria-hidden="true"
      {...props}
      className={cn("shrink-0", className, props.className)}
    >
      {children}
    </svg>
  );
}

function Code2Icon(props: IconProps) {
  return iconBase(
    <>
      <path d="m8 8-4 4 4 4" />
      <path d="m16 8 4 4-4 4" />
      <path d="m14 4-4 16" />
    </>,
    props,
  );
}

function MenuIcon(props: IconProps) {
  return iconBase(
    <>
      <path d="M4 7h16" />
      <path d="M4 12h16" />
      <path d="M4 17h16" />
    </>,
    props,
  );
}

function XIcon(props: IconProps) {
  return iconBase(
    <>
      <path d="m6 6 12 12" />
      <path d="m18 6-12 12" />
    </>,
    props,
  );
}

function TerminalIcon(props: IconProps) {
  return iconBase(
    <>
      <path d="m4 17 6-5-6-5" />
      <path d="M12 19h8" />
    </>,
    props,
  );
}

function ChevronDownIcon(props: IconProps) {
  return iconBase(<path d="m6 9 6 6 6-6" />, props);
}

function UserIcon(props: IconProps) {
  return iconBase(
    <>
      <path d="M12 13a4 4 0 1 0 0-8 4 4 0 0 0 0 8Z" />
      <path d="M4 20a8 8 0 0 1 16 0" />
    </>,
    props,
  );
}

function BriefcaseIcon(props: IconProps) {
  return iconBase(
    <>
      <rect x="3" y="7" width="18" height="12" rx="2" />
      <path d="M8 7V5a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2" />
      <path d="M3 12h18" />
    </>,
    props,
  );
}

function MapPinIcon(props: IconProps) {
  return iconBase(
    <>
      <path d="M12 21s6-5.33 6-11a6 6 0 1 0-12 0c0 5.67 6 11 6 11Z" />
      <path d="M12 12a2.5 2.5 0 1 0 0-5 2.5 2.5 0 0 0 0 5Z" />
    </>,
    props,
  );
}

function MailIcon(props: IconProps) {
  return iconBase(
    <>
      <rect x="3" y="5" width="18" height="14" rx="2" />
      <path d="m4 7 8 6 8-6" />
    </>,
    props,
  );
}

function PaletteIcon(props: IconProps) {
  return iconBase(
    <>
      <path d="M12 3a9 9 0 0 0 0 18h1a2 2 0 0 0 0-4h-1a2 2 0 0 1 0-4h1a4 4 0 0 0 0-8h-1Z" />
      <path d="M7.5 10.5h.01" />
      <path d="M8.5 7.5h.01" />
      <path d="M12 6h.01" />
      <path d="M16 8h.01" />
    </>,
    props,
  );
}

function ServerIcon(props: IconProps) {
  return iconBase(
    <>
      <rect x="3" y="4" width="18" height="6" rx="2" />
      <rect x="3" y="14" width="18" height="6" rx="2" />
      <path d="M7 7h.01" />
      <path d="M7 17h.01" />
      <path d="M12 10v4" />
    </>,
    props,
  );
}

function DatabaseIcon(props: IconProps) {
  return iconBase(
    <>
      <ellipse cx="12" cy="6" rx="7" ry="3" />
      <path d="M5 6v6c0 1.66 3.13 3 7 3s7-1.34 7-3V6" />
      <path d="M5 12v6c0 1.66 3.13 3 7 3s7-1.34 7-3v-6" />
    </>,
    props,
  );
}

function CpuIcon(props: IconProps) {
  return iconBase(
    <>
      <rect x="7" y="7" width="10" height="10" rx="2" />
      <path d="M9 1v3" />
      <path d="M15 1v3" />
      <path d="M9 20v3" />
      <path d="M15 20v3" />
      <path d="M20 9h3" />
      <path d="M20 14h3" />
      <path d="M1 9h3" />
      <path d="M1 14h3" />
    </>,
    props,
  );
}

function CodeIcon(props: IconProps) {
  return iconBase(
    <>
      <path d="m9 18-6-6 6-6" />
      <path d="m15 6 6 6-6 6" />
    </>,
    props,
  );
}

function GitHubIcon(props: IconProps) {
  return (
    <svg
      viewBox="0 0 24 24"
      fill="currentColor"
      aria-hidden="true"
      {...props}
      className={cn("shrink-0", props.className)}
    >
      <path d="M12 2a10 10 0 0 0-3.16 19.49c.5.09.68-.22.68-.48v-1.7c-2.78.6-3.37-1.18-3.37-1.18-.46-1.16-1.11-1.47-1.11-1.47-.91-.61.07-.6.07-.6 1 .08 1.54 1.03 1.54 1.03.9 1.53 2.35 1.09 2.92.83.09-.65.35-1.09.63-1.34-2.22-.25-4.56-1.11-4.56-4.94 0-1.09.39-1.98 1.03-2.68-.1-.26-.45-1.3.1-2.71 0 0 .84-.27 2.75 1.03A9.5 9.5 0 0 1 12 6.84c.85 0 1.71.11 2.51.34 1.91-1.3 2.75-1.03 2.75-1.03.55 1.41.2 2.45.1 2.71.64.7 1.03 1.59 1.03 2.68 0 3.84-2.34 4.69-4.57 4.94.36.31.68.92.68 1.87v2.76c0 .27.18.58.69.48A10 10 0 0 0 12 2Z" />
    </svg>
  );
}

function ExternalLinkIcon(props: IconProps) {
  return iconBase(
    <>
      <path d="M14 5h5v5" />
      <path d="M10 14 19 5" />
      <path d="M19 13v5a2 2 0 0 1-2 2H6a2 2 0 0 1-2-2V7a2 2 0 0 1 2-2h5" />
    </>,
    props,
  );
}

function LinkedinIcon(props: IconProps) {
  return (
    <svg
      viewBox="0 0 24 24"
      fill="currentColor"
      aria-hidden="true"
      {...props}
      className={cn("shrink-0", props.className)}
    >
      <path d="M6.94 8.76H3.56V20h3.38V8.76ZM5.25 3A1.97 1.97 0 1 0 5.3 6.94 1.97 1.97 0 0 0 5.25 3ZM20.44 12.9c0-3.37-1.8-4.94-4.2-4.94-1.93 0-2.8 1.06-3.28 1.8V8.76H9.58V20h3.38v-6.28c0-1.65.31-3.25 2.35-3.25 2.01 0 2.04 1.88 2.04 3.35V20h3.38l-.29-7.1Z" />
    </svg>
  );
}

function SendIcon(props: IconProps) {
  return iconBase(
    <>
      <path d="M3 11.5 21 3l-8.5 18-2.5-7L3 11.5Z" />
      <path d="M10 14 21 3" />
    </>,
    props,
  );
}

function Loader2Icon(props: IconProps) {
  return iconBase(
    <>
      <path d="M12 3a9 9 0 1 0 9 9" />
    </>,
    props,
  );
}

function CheckCircle2Icon(props: IconProps) {
  return iconBase(
    <>
      <circle cx="12" cy="12" r="9" />
      <path d="m8.5 12.5 2.5 2.5 4.5-5" />
    </>,
    props,
  );
}

function BackgroundScene() {
  const [particles] = useState<Particle[]>(() =>
    Array.from({ length: 30 }, () => ({
      left: `${Math.random() * 100}%`,
      top: `${Math.random() * 100}%`,
      delay: `${Math.random() * 8}s`,
      duration: `${4 + Math.random() * 6}s`,
      size: Number((1 + Math.random() * 2).toFixed(2)),
    })),
  );

  return (
    <div className="fixed inset-0 z-0 overflow-hidden bg-background pointer-events-none">
      <div className="cyber-grid absolute inset-0" />
      <div className="aurora absolute inset-0" />
      <div className="scanlines absolute inset-0 opacity-80" />
      {particles.map((particle, index) => (
        <div
          key={`${particle.left}-${particle.top}-${index}`}
          className="particle"
          style={{
            left: particle.left,
            top: particle.top,
            animationDelay: particle.delay,
            animationDuration: particle.duration,
            width: particle.size,
            height: particle.size,
          }}
        />
      ))}
      <div className="float-orb float-orb-1" />
      <div className="float-orb float-orb-2" />
      <div className="float-orb float-orb-3" />
      <div className="float-wire float-wire-1" />
      <div className="float-wire float-wire-2" />
      <div className="vignette absolute inset-0" />
    </div>
  );
}

function GlassCard({
  children,
  className,
  glowColor = "none",
}: {
  children: ReactNode;
  className?: string;
  glowColor?: GlowColor;
}) {
  const glowClass =
    glowColor === "cyan"
      ? "hover:border-neon-cyan/50 hover:shadow-[0_0_30px_rgba(0,243,255,0.15)]"
      : glowColor === "purple"
        ? "hover:border-neon-purple/50 hover:shadow-[0_0_30px_rgba(139,92,246,0.15)]"
        : glowColor === "pink"
          ? "hover:border-neon-pink/50 hover:shadow-[0_0_30px_rgba(236,72,153,0.15)]"
          : "";

  return (
    <motion.div
      initial={{ opacity: 0, y: 20 }}
      whileInView={{ opacity: 1, y: 0 }}
      viewport={{ once: true }}
      transition={sectionTransition}
      className={cn(
        "glass-panel group relative overflow-hidden rounded-2xl border border-white/8 p-6 transition-all duration-300",
        glowClass,
        className,
      )}
    >
      <div className="absolute inset-x-0 top-0 h-px bg-gradient-to-r from-transparent via-white/20 to-transparent" />
      {children}
    </motion.div>
  );
}

function SectionHeader({
  prefix,
  accent,
  accentClass,
  glowClass,
  lineClass,
}: {
  prefix: string;
  accent: string;
  accentClass: string;
  glowClass: string;
  lineClass: string;
}) {
  return (
    <motion.div
      initial={{ opacity: 0, y: 20 }}
      whileInView={{ opacity: 1, y: 0 }}
      viewport={{ once: true }}
      transition={sectionTransition}
      className="mb-14 flex items-center gap-4"
    >
      <div className={cn("h-px flex-1", lineClass)} />
      <h2
        className={cn(
          "text-center text-3xl font-display font-bold uppercase tracking-widest text-foreground md:text-4xl",
          glowClass,
        )}
      >
        {prefix}.<span className={accentClass}>{accent}</span>
      </h2>
      <div className={cn("h-px flex-1", lineClass)} />
    </motion.div>
  );
}

function TiltPanel({
  children,
  settings,
  className,
}: {
  children: ReactNode;
  settings: TiltSettings;
  className?: string;
}) {
  const [tiltStyle, setTiltStyle] = useState<CSSProperties>({
    transform:
      "perspective(1200px) rotateX(0deg) rotateY(0deg) scale3d(1, 1, 1)",
    transition: `transform ${settings.speed}ms ease`,
  });
  const [glare, setGlare] = useState({
    x: 50,
    y: 50,
    opacity: 0,
  });

  const handleMove = (event: MouseEvent<HTMLDivElement>) => {
    const bounds = event.currentTarget.getBoundingClientRect();
    const px = (event.clientX - bounds.left) / bounds.width;
    const py = (event.clientY - bounds.top) / bounds.height;
    const rotateY = (px - 0.5) * settings.max * 2;
    const rotateX = (0.5 - py) * settings.max * 2;

    setTiltStyle({
      transform: `perspective(1200px) rotateX(${rotateX.toFixed(2)}deg) rotateY(${rotateY.toFixed(2)}deg) scale3d(${settings.scale}, ${settings.scale}, ${settings.scale})`,
      transition: "transform 120ms ease-out",
    });
    setGlare({
      x: px * 100,
      y: py * 100,
      opacity: settings.maxGlare,
    });
  };

  const handleLeave = () => {
    setTiltStyle({
      transform:
        "perspective(1200px) rotateX(0deg) rotateY(0deg) scale3d(1, 1, 1)",
      transition: `transform ${settings.speed}ms ease`,
    });
    setGlare({
      x: 50,
      y: 50,
      opacity: 0,
    });
  };

  return (
    <div
      className={cn("relative h-full [transform-style:preserve-3d]", className)}
      style={tiltStyle}
      onMouseMove={handleMove}
      onMouseLeave={handleLeave}
    >
      <div
        aria-hidden="true"
        className="pointer-events-none absolute inset-0 z-10 rounded-[inherit] mix-blend-screen transition-opacity duration-300"
        style={{
          background: `radial-gradient(circle at ${glare.x}% ${glare.y}%, rgba(255,255,255,${glare.opacity}), transparent 42%)`,
        }}
      />
      {children}
    </div>
  );
}

function Navbar({
  scrolled,
  mobileMenuOpen,
  onToggleMenu,
  onNavigate,
}: {
  scrolled: boolean;
  mobileMenuOpen: boolean;
  onToggleMenu: () => void;
  onNavigate: (id: SectionId) => void;
}) {
  return (
    <motion.header
      initial={{ y: -100 }}
      animate={{ y: 0 }}
      transition={{ duration: 0.7, ease: "easeOut" }}
      className={cn(
        "fixed inset-x-0 top-0 z-50 border-b transition-all duration-300",
        scrolled
          ? "border-white/10 bg-background/80 py-4 shadow-lg shadow-black/50 backdrop-blur-md"
          : "border-transparent bg-transparent py-6",
      )}
    >
      <div className="mx-auto flex max-w-7xl items-center justify-between px-5 lg:px-10">
        <button
          type="button"
          onClick={() => onNavigate("home")}
          className="flex items-center gap-3 text-left"
        >
          <span className="box-glow-cyan flex items-center justify-center rounded-lg border border-primary/30 bg-primary/10 p-2 text-primary">
            <Code2Icon className="h-5 w-5" />
          </span>
          <span className="font-display text-xl font-bold tracking-[0.24em] text-foreground">
            SACHIN<span className="text-primary">.LAL</span>
          </span>
        </button>

        <nav className="hidden items-center gap-8 lg:flex">
          {navItems.map((item) => (
            <button
              key={item.id}
              type="button"
              onClick={() => onNavigate(item.id)}
              className="group relative text-sm font-semibold uppercase tracking-wider text-muted-foreground transition-colors hover:text-primary"
            >
              {item.label}
              <span className="box-glow-cyan absolute -bottom-2 left-0 h-0.5 w-0 bg-primary transition-all duration-300 group-hover:w-full" />
            </button>
          ))}
        </nav>

        <div className="hidden items-center gap-4 lg:flex">
          <button
            type="button"
            onClick={() => onNavigate("contact")}
            className="box-glow-cyan rounded-full border border-primary/50 bg-primary/10 px-5 py-2.5 font-display text-sm font-bold uppercase tracking-wider text-primary transition-all duration-300 hover:bg-primary hover:text-primary-foreground"
          >
            Hire Me
          </button>
        </div>

        <button
          type="button"
          onClick={onToggleMenu}
          className="rounded-xl border border-white/10 bg-card/70 p-3 text-foreground backdrop-blur-xl lg:hidden"
          aria-label={mobileMenuOpen ? "Close navigation menu" : "Open navigation menu"}
        >
          {mobileMenuOpen ? (
            <XIcon className="h-5 w-5" />
          ) : (
            <MenuIcon className="h-5 w-5" />
          )}
        </button>
      </div>

      <AnimatePresence>
        {mobileMenuOpen ? (
          <motion.div
            initial={{ opacity: 0, height: 0 }}
            animate={{ opacity: 1, height: "auto" }}
            exit={{ opacity: 0, height: 0 }}
            transition={{ duration: 0.25, ease: "easeOut" }}
            className="overflow-hidden border-b border-white/10 bg-card/95 backdrop-blur-xl lg:hidden"
          >
            <div className="mx-auto flex max-w-7xl flex-col gap-2 px-5 py-4">
              {navItems.map((item) => (
                <button
                  key={item.id}
                  type="button"
                  onClick={() => onNavigate(item.id)}
                  className="rounded-xl px-3 py-3 text-left font-semibold uppercase tracking-wider text-muted-foreground transition-colors hover:bg-white/5 hover:text-primary"
                >
                  {item.label}
                </button>
              ))}
              <button
                type="button"
                onClick={() => onNavigate("contact")}
                className="mt-2 rounded-xl border border-primary/40 bg-primary/10 px-4 py-3 font-display font-bold uppercase tracking-wider text-primary"
              >
                Hire Me
              </button>
            </div>
          </motion.div>
        ) : null}
      </AnimatePresence>
    </motion.header>
  );
}

function Hero({ title }: { title: string }) {
  return (
    <section
      id="home"
      className="relative z-10 flex min-h-screen items-center justify-center overflow-hidden pt-20"
    >
      <div className="mx-auto flex max-w-5xl flex-col items-center px-5 text-center lg:px-10">
        <motion.div
          initial={{ opacity: 0, scale: 0.8 }}
          animate={{ opacity: 1, scale: 1 }}
          transition={{ duration: 0.5, ease: "easeOut" }}
          className="box-glow-purple mb-8 rounded-2xl border border-secondary/30 bg-secondary/10 p-3 text-secondary"
        >
          <TerminalIcon className="h-8 w-8" />
        </motion.div>

        <motion.p
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.2, duration: 0.5, ease: "easeOut" }}
          className="text-glow-cyan mb-4 font-display text-sm uppercase tracking-[0.3em] text-primary md:text-base"
        >
          Hello, World. I Am
        </motion.p>

        <motion.h1
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.4, duration: 0.5, ease: "easeOut" }}
          className="mb-4 text-5xl font-black tracking-tight text-foreground md:text-7xl lg:text-8xl"
        >
          SACHIN{" "}
          <span className="bg-gradient-to-r from-primary to-secondary bg-clip-text text-transparent">
            LAL
          </span>
        </motion.h1>

        <motion.div
          initial={{ opacity: 0 }}
          animate={{ opacity: 1 }}
          transition={{ delay: 0.6, duration: 0.5, ease: "easeOut" }}
          className="mb-10 flex h-12 items-center justify-center"
        >
          <p className="flex items-center gap-3 text-2xl font-light text-muted-foreground md:text-3xl">
            <span className="font-mono text-primary">&gt;</span>
            <span className="font-mono">{title}</span>
            <motion.span
              animate={{ opacity: [1, 0] }}
              transition={{ repeat: Infinity, duration: 0.8 }}
              className="inline-block h-8 w-3 bg-primary"
            />
          </p>
        </motion.div>

        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.8, duration: 0.5, ease: "easeOut" }}
          className="flex flex-col gap-4 sm:flex-row"
        >
          <ScrollButton
            target="projects"
            className="box-glow-cyan rounded-xl border border-primary bg-primary/10 px-8 py-4 font-display font-bold uppercase tracking-wider text-primary transition-all duration-300 hover:bg-primary hover:text-primary-foreground"
          >
            View Projects
          </ScrollButton>
          <ScrollButton
            target="contact"
            className="rounded-xl border border-secondary bg-secondary/10 px-8 py-4 font-display font-bold uppercase tracking-wider text-secondary shadow-[0_0_15px_rgba(139,92,246,0.2)] transition-all duration-300 hover:bg-secondary hover:text-secondary-foreground hover:shadow-[0_0_25px_rgba(139,92,246,0.5)]"
          >
            Contact Me
          </ScrollButton>
        </motion.div>
      </div>

      <motion.div
        initial={{ opacity: 0 }}
        animate={{ opacity: 1, y: [0, 10, 0] }}
        transition={{ delay: 1.5, duration: 2, repeat: Infinity }}
        className="absolute bottom-10 left-1/2 -translate-x-1/2 text-primary"
      >
        <ChevronDownIcon className="h-8 w-8" />
      </motion.div>
    </section>
  );
}

function ProfileScanReveal({
  src,
  alt,
  priority = false,
  imageClassName,
}: {
  src: string;
  alt: string;
  priority?: boolean;
  imageClassName?: string;
}) {
  const [revealed, setRevealed] = useState(false);

  useEffect(() => {
    const delay = window.setTimeout(() => {
      setRevealed(true);
    }, 1750);

    return () => window.clearTimeout(delay);
  }, []);

  return (
    <div className="absolute inset-0">
      <motion.div
        className="absolute inset-0"
        initial={false}
        animate={{
          opacity: revealed ? 1 : 0,
          scale: revealed ? 1 : 1.03,
          filter: revealed ? "blur(0px)" : "blur(10px)",
        }}
        transition={{ duration: 0.7, ease: "easeOut" }}
      >
        <Image
          src={src}
          alt={alt}
          fill
          sizes="(max-width: 1024px) 100vw, 60vw"
          className={cn(imageClassName, "transition-transform duration-700")}
          priority={priority}
        />
      </motion.div>

      <AnimatePresence>
        {!revealed ? (
          <motion.div
            key="scan-overlay"
            initial={{ opacity: 0 }}
            animate={{ opacity: 1 }}
            exit={{ opacity: 0 }}
            transition={{ duration: 0.25, ease: "easeOut" }}
            className="absolute inset-0 overflow-hidden bg-[linear-gradient(180deg,rgba(6,9,20,0.86),rgba(6,9,20,0.34))]"
          >
            <motion.div
              className="absolute inset-x-0 top-0 h-16 bg-[linear-gradient(180deg,rgba(0,243,255,0),rgba(0,243,255,0.35),rgba(236,72,153,0.18),rgba(0,243,255,0))] blur-[2px]"
              animate={{ y: ["-20%", "115%"] }}
              transition={{ duration: 1.5, ease: "easeInOut" }}
            />
            <div className="absolute inset-0 bg-[linear-gradient(rgba(255,255,255,0.04)_1px,transparent_1px),linear-gradient(90deg,rgba(255,255,255,0.04)_1px,transparent_1px)] bg-[size:28px_28px] opacity-40" />
            <motion.div
              className="absolute inset-x-0 top-1/2 h-px bg-primary/80 shadow-[0_0_24px_rgba(0,243,255,0.8)]"
              animate={{ opacity: [0.25, 1, 0.25], scaleX: [0.88, 1, 0.88] }}
              transition={{ duration: 1.5, repeat: Infinity, ease: "easeInOut" }}
            />
            <div className="absolute inset-x-8 bottom-8 rounded-2xl border border-primary/30 bg-background/70 px-4 py-3 font-mono text-xs uppercase tracking-[0.28em] text-primary backdrop-blur-md">
              Scanning profile...
            </div>
          </motion.div>
        ) : null}
      </AnimatePresence>
    </div>
  );
}

function ScrollButton({
  target,
  children,
  className,
}: {
  target: SectionId;
  children: ReactNode;
  className: string;
}) {
  const handleClick = () => {
    document.getElementById(target)?.scrollIntoView({ behavior: "smooth" });
  };

  return (
    <button type="button" onClick={handleClick} className={className}>
      {children}
    </button>
  );
}

function AboutSection() {
  return (
    <section id="about" className="relative z-10 py-24">
      <div className="mx-auto max-w-7xl px-5 lg:px-10">
        <SectionHeader
          prefix="System"
          accent="About"
          accentClass="text-primary"
          glowClass="text-glow-cyan"
          lineClass="bg-primary/50 box-glow-cyan"
        />

        <div className="grid grid-cols-1 items-center gap-8 lg:grid-cols-12">
          <motion.div
            initial={{ opacity: 0, x: -50 }}
            whileInView={{ opacity: 1, x: 0 }}
            viewport={{ once: true }}
            transition={sectionTransition}
            className="lg:col-span-5"
          >
            <div className="group relative mx-auto w-fit">
              <div className="absolute inset-0 rounded-2xl bg-gradient-to-tr from-primary to-secondary blur-xl opacity-30 transition-opacity duration-500 group-hover:opacity-50" />
              <div className="absolute -left-2 -top-2 z-20 h-6 w-6 border-l-2 border-t-2 border-primary" />
              <div className="absolute -bottom-2 -right-2 z-20 h-6 w-6 border-b-2 border-r-2 border-secondary" />
              <Image
                src="/images/avatar.png"
                alt="Stylized portrait of Sachin Lal"
                width={320}
                height={320}
                priority
                className="relative h-64 w-64 rounded-2xl border-2 border-white/10 object-cover transition-colors duration-300 group-hover:border-primary/50 md:h-80 md:w-80"
              />
            </div>
          </motion.div>

          <motion.div
            initial={{ opacity: 0, x: 50 }}
            whileInView={{ opacity: 1, x: 0 }}
            viewport={{ once: true }}
            transition={sectionTransition}
            className="lg:col-span-7"
          >
            <GlassCard glowColor="cyan">
              <h3 className="mb-6 text-2xl font-display font-bold text-foreground">
                Initializing Profile...
              </h3>
              <p className="mb-6 text-lg leading-relaxed text-muted-foreground">
                I am a Flutter Developer with experience across Digitlay
                Infotech, Tech Almonds Solutions, and SDGI Technosystems,
                building cross-platform mobile and web applications with Dart,
                reusable widgets, and dependable delivery workflows.
              </p>
              <p className="mb-8 text-lg leading-relaxed text-muted-foreground">
                My resume work includes loyalty and rewards platforms, civic
                engagement systems, role-based dashboards, Zego-powered live
                communication, map monitoring, geofencing, OCR-based result
                processing, secure authentication, and production API
                integrations.
              </p>

              <div className="grid grid-cols-1 gap-4 sm:grid-cols-2">
                {infoItems.map((item) => {
                  const Icon = item.icon;
                  return (
                    <div
                      key={item.value}
                      className="flex items-center gap-3 rounded-xl border border-white/8 bg-white/4 px-4 py-4"
                    >
                      <Icon className={cn("h-5 w-5", item.color)} />
                      <span className="text-base text-foreground">{item.value}</span>
                    </div>
                  );
                })}
              </div>
            </GlassCard>
          </motion.div>
        </div>
      </div>
    </section>
  );
}

function SkillsSection() {
  return (
    <section id="skills" className="relative z-10 py-24">
      <div className="mx-auto max-w-7xl px-5 lg:px-10">
        <SectionHeader
          prefix="Tech"
          accent="Arsenal"
          accentClass="text-secondary"
          glowClass="text-glow-purple"
          lineClass="bg-secondary/50"
        />

        <div className="grid grid-cols-1 gap-6 md:grid-cols-2 lg:grid-cols-3">
          {skillCategories.map((category, index) => {
            const Icon = category.icon;
            const iconClass =
              category.color === "cyan"
                ? "bg-primary/10 text-primary border-primary/30"
                : category.color === "purple"
                  ? "bg-secondary/10 text-secondary border-secondary/30"
                  : "bg-accent/10 text-accent border-accent/30";

            return (
              <motion.div
                key={category.title}
                initial={{ opacity: 0, y: 20 }}
                whileInView={{ opacity: 1, y: 0 }}
                viewport={{ once: true }}
                transition={{ ...sectionTransition, delay: index * 0.1 }}
              >
                <TiltPanel settings={skillTilt} className="h-full rounded-2xl">
                  <GlassCard glowColor={category.color} className="h-full">
                    <div
                      className={cn(
                        "mb-6 flex h-12 w-12 items-center justify-center rounded-xl border",
                        iconClass,
                      )}
                    >
                      <Icon className="h-6 w-6" />
                    </div>
                    <h3 className="mb-4 text-xl font-display font-bold text-foreground">
                      {category.title}
                    </h3>
                    <div className="flex flex-wrap gap-2">
                      {category.skills.map((skill) => (
                        <span
                          key={skill}
                          className="rounded-md border border-white/10 bg-white/5 px-3 py-1 text-sm font-medium text-muted-foreground transition-colors hover:bg-white/10 hover:text-foreground"
                        >
                          {skill}
                        </span>
                      ))}
                    </div>
                  </GlassCard>
                </TiltPanel>
              </motion.div>
            );
          })}
        </div>
      </div>
    </section>
  );
}

function ProjectsSection() {
  return (
    <section id="projects" className="relative z-10 py-24">
      <div className="mx-auto max-w-7xl px-5 lg:px-10">
        <SectionHeader
          prefix="Deploy"
          accent="Logs"
          accentClass="text-accent"
          glowClass="text-glow-cyan"
          lineClass="bg-accent/50"
        />

        <div className="grid grid-cols-1 gap-8 lg:grid-cols-2">
          {projects.map((project, index) => (
            <motion.div
              key={project.title}
              initial={{ opacity: 0, y: 20 }}
              whileInView={{ opacity: 1, y: 0 }}
              viewport={{ once: true }}
              transition={{ ...sectionTransition, delay: index * 0.1 }}
            >
              <TiltPanel settings={projectTilt} className="h-full rounded-2xl">
                <GlassCard glowColor="cyan" className="flex h-full flex-col overflow-hidden p-0">
                  <div className="group relative flex h-full flex-col">
                    <div className="relative h-60 overflow-hidden border-b border-white/10">
                      <div className="absolute inset-0 z-10 bg-primary/20 mix-blend-overlay transition-colors duration-500 group-hover:bg-transparent" />
                      <Image
                        src={project.image}
                        alt={project.title}
                        fill
                        sizes="(max-width: 1024px) 100vw, 50vw"
                        className="object-cover transition-transform duration-700 group-hover:scale-110"
                      />
                    </div>

                    <div className="flex flex-1 flex-col p-6">
                      <div className="mb-4 flex items-start justify-between gap-4">
                        <h3 className="text-2xl font-display font-bold text-foreground transition-colors group-hover:text-primary">
                          {project.title}
                        </h3>
                        <div className="flex items-center gap-3 text-muted-foreground">
                          <a
                            href={project.github}
                            target="_blank"
                            rel="noreferrer"
                            className="transition-colors hover:text-primary"
                            aria-label={`${project.title} GitHub repository`}
                          >
                            <GitHubIcon className="h-5 w-5" />
                          </a>
                          <a
                            href={project.live}
                            target="_blank"
                            rel="noreferrer"
                            className="transition-colors hover:text-primary"
                            aria-label={`${project.title} live project`}
                          >
                            <ExternalLinkIcon className="h-5 w-5" />
                          </a>
                        </div>
                      </div>
                      <p className="mb-6 flex-1 text-base leading-relaxed text-muted-foreground">
                        {project.description}
                      </p>
                      <div className="flex flex-wrap gap-2">
                        {project.tags.map((tag) => (
                          <span
                            key={tag}
                            className="rounded bg-primary/10 px-2 py-1 font-mono text-xs text-primary"
                          >
                            {tag}
                          </span>
                        ))}
                      </div>
                    </div>
                  </div>
                </GlassCard>
              </TiltPanel>
            </motion.div>
          ))}
        </div>
      </div>
    </section>
  );
}

function ContactSection({
  formValues,
  submitState,
  onChange,
  onSubmit,
}: {
  formValues: { name: string; email: string; message: string };
  submitState: "idle" | "loading" | "success";
  onChange: (
    event: ChangeEvent<HTMLInputElement | HTMLTextAreaElement>,
  ) => void;
  onSubmit: (event: FormEvent<HTMLFormElement>) => void;
}) {
  return (
    <section id="contact" className="relative z-10 py-24">
      <div className="mx-auto max-w-7xl px-5 lg:px-10">
        <SectionHeader
          prefix="Init"
          accent="Connection"
          accentClass="text-primary"
          glowClass="text-glow-cyan"
          lineClass="bg-primary/50 box-glow-cyan"
        />

        <div className="grid grid-cols-1 gap-12 lg:grid-cols-2">
          <motion.div
            initial={{ opacity: 0, x: -30 }}
            whileInView={{ opacity: 1, x: 0 }}
            viewport={{ once: true }}
            transition={sectionTransition}
          >
            <h3 className="mb-6 text-4xl font-black text-foreground md:text-5xl">
              Let&apos;s Build Something{" "}
              <span className="bg-gradient-to-r from-primary to-secondary bg-clip-text text-transparent">
                Mobile.
              </span>
            </h3>
            <p className="mb-10 text-lg leading-relaxed text-muted-foreground">
              Open to Flutter roles, mobile product teams, and conversations
              about app architecture, rewards workflows, dashboard systems, and
              API-driven delivery. Drop a message or connect on my profiles.
            </p>

            <div className="flex flex-col gap-5">
              {socialLinks.map((item) => {
                const Icon = item.icon;
                const hoverClass =
                  item.color === "cyan"
                    ? "hover:border-primary/50 hover:bg-primary/20 hover:text-primary"
                    : item.color === "purple"
                      ? "hover:border-secondary/50 hover:bg-secondary/20 hover:text-secondary"
                      : "hover:border-accent/50 hover:bg-accent/20 hover:text-accent";

                return (
                  <a
                    key={item.label}
                    href={item.href}
                    target="_blank"
                    rel="noreferrer"
                    className="group flex w-fit items-center gap-4"
                  >
                    <span
                      className={cn(
                        "flex h-12 w-12 items-center justify-center rounded-full border border-white/10 bg-white/5 text-foreground transition-all duration-300",
                        hoverClass,
                      )}
                    >
                      <Icon className="h-5 w-5" />
                    </span>
                    <span className="font-mono text-xl text-muted-foreground transition-colors group-hover:text-foreground">
                      {item.handle}
                    </span>
                  </a>
                );
              })}
            </div>
          </motion.div>

          <motion.div
            initial={{ opacity: 0, x: 30 }}
            whileInView={{ opacity: 1, x: 0 }}
            viewport={{ once: true }}
            transition={sectionTransition}
          >
            <GlassCard glowColor="purple" className="p-8">
              <form className="space-y-6" onSubmit={onSubmit}>
                <FormField
                  label="Identify_As"
                  name="name"
                  value={formValues.name}
                  placeholder="John Doe"
                  onChange={onChange}
                />
                <FormField
                  label="Return_Address"
                  name="email"
                  type="email"
                  value={formValues.email}
                  placeholder="john@example.com"
                  onChange={onChange}
                />
                <FormField
                  label="Payload"
                  name="message"
                  value={formValues.message}
                  placeholder="Initialize communication protocol..."
                  onChange={onChange}
                  multiline
                />

                <button
                  type="submit"
                  disabled={submitState === "loading"}
                  className="box-glow-purple flex w-full items-center justify-center gap-2 rounded-xl border border-secondary/50 bg-secondary/20 py-4 font-display font-bold uppercase tracking-wider text-secondary transition-all duration-300 hover:bg-secondary hover:text-white disabled:opacity-50"
                >
                  {submitState === "loading" ? (
                    <>
                      <Loader2Icon className="h-5 w-5 animate-spin" />
                      Transmitting...
                    </>
                  ) : submitState === "success" ? (
                    <>
                      <CheckCircle2Icon className="h-5 w-5" />
                      Transmitted
                    </>
                  ) : (
                    <>
                      <SendIcon className="h-5 w-5" />
                      Execute
                    </>
                  )}
                </button>
              </form>
            </GlassCard>
          </motion.div>
        </div>
      </div>
    </section>
  );
}

function FormField({
  label,
  name,
  value,
  placeholder,
  onChange,
  type = "text",
  multiline = false,
}: {
  label: string;
  name: string;
  value: string;
  placeholder: string;
  onChange: (
    event: ChangeEvent<HTMLInputElement | HTMLTextAreaElement>,
  ) => void;
  type?: string;
  multiline?: boolean;
}) {
  const baseClassName =
    "w-full rounded-xl border border-white/10 bg-background/50 px-4 py-3 font-sans text-foreground transition-all placeholder:text-muted-foreground/50 focus:border-secondary focus:outline-none focus:ring-1 focus:ring-secondary/50";

  return (
    <label className="block space-y-2">
      <span className="font-mono text-sm uppercase tracking-wider text-muted-foreground">
        {label}
      </span>
      {multiline ? (
        <textarea
          required
          name={name}
          value={value}
          rows={5}
          placeholder={placeholder}
          onChange={onChange}
          className={cn(baseClassName, "resize-none")}
        />
      ) : (
        <input
          required
          type={type}
          name={name}
          value={value}
          placeholder={placeholder}
          onChange={onChange}
          className={baseClassName}
        />
      )}
    </label>
  );
}

function Toast({ open }: { open: boolean }) {
  return (
    <AnimatePresence>
      {open ? (
        <motion.div
          initial={{ opacity: 0, y: 18 }}
          animate={{ opacity: 1, y: 0 }}
          exit={{ opacity: 0, y: 18 }}
          transition={{ duration: 0.25, ease: "easeOut" }}
          className="fixed bottom-6 right-6 z-[70] max-w-sm rounded-2xl border border-primary/30 bg-card/90 p-4 shadow-[0_20px_50px_rgba(0,0,0,0.35)] backdrop-blur-xl"
        >
          <div className="flex items-start gap-3">
            <span className="mt-0.5 rounded-full bg-primary/10 p-2 text-primary">
              <CheckCircle2Icon className="h-4 w-4" />
            </span>
            <div>
              <p className="font-display text-sm font-bold uppercase tracking-wider text-foreground">
                Message Transmitted
              </p>
              <p className="mt-1 text-sm leading-relaxed text-muted-foreground">
                Your message has been successfully logged to the server.
              </p>
            </div>
          </div>
        </motion.div>
      ) : null}
    </AnimatePresence>
  );
}

export function PortfolioPage() {
  const [scrolled, setScrolled] = useState(false);
  const [mobileMenuOpen, setMobileMenuOpen] = useState(false);
  const [visibleTitle, setVisibleTitle] = useState("");
  const [formValues, setFormValues] = useState({
    name: "",
    email: "",
    message: "",
  });
  const [submitState, setSubmitState] = useState<"idle" | "loading" | "success">(
    "idle",
  );
  const [toastOpen, setToastOpen] = useState(false);
  const submitResetTimeout = useRef<number | null>(null);

  useEffect(() => {
    const updateScrollState = () => {
      setScrolled(window.scrollY > 50);
    };

    updateScrollState();
    window.addEventListener("scroll", updateScrollState);
    return () => window.removeEventListener("scroll", updateScrollState);
  }, []);

  useEffect(() => {
    let index = 0;
    const interval = window.setInterval(() => {
      index += 1;
      setVisibleTitle(typedTitle.slice(0, index));
      if (index >= typedTitle.length) {
        window.clearInterval(interval);
      }
    }, 100);

    return () => window.clearInterval(interval);
  }, []);

  useEffect(() => {
    if (!toastOpen) {
      return undefined;
    }

    const timeout = window.setTimeout(() => {
      setToastOpen(false);
    }, 3200);

    return () => window.clearTimeout(timeout);
  }, [toastOpen]);

  useEffect(() => {
    return () => {
      if (submitResetTimeout.current) {
        window.clearTimeout(submitResetTimeout.current);
      }
    };
  }, []);

  const navigateToSection = (id: SectionId) => {
    setMobileMenuOpen(false);
    document.getElementById(id)?.scrollIntoView({ behavior: "smooth" });
  };

  const handleInputChange = (
    event: ChangeEvent<HTMLInputElement | HTMLTextAreaElement>,
  ) => {
    const { name, value } = event.target;
    setFormValues((current) => ({
      ...current,
      [name]: value,
    }));
  };

  const handleSubmit = async (event: FormEvent<HTMLFormElement>) => {
    event.preventDefault();
    if (submitState === "loading") {
      return;
    }

    setSubmitState("loading");
    await new Promise((resolve) => {
      window.setTimeout(resolve, 1500);
    });

    setSubmitState("success");
    setFormValues({
      name: "",
      email: "",
      message: "",
    });
    setToastOpen(true);

    if (submitResetTimeout.current) {
      window.clearTimeout(submitResetTimeout.current);
    }

    submitResetTimeout.current = window.setTimeout(() => {
      setSubmitState("idle");
    }, 2200);
  };

  return (
    <main className="relative min-h-screen bg-background text-foreground selection:bg-primary/30">
      <BackgroundScene />
      <Navbar
        scrolled={scrolled}
        mobileMenuOpen={mobileMenuOpen}
        onToggleMenu={() => setMobileMenuOpen((current) => !current)}
        onNavigate={navigateToSection}
      />

      <div className="relative z-10 flex flex-col gap-20 pb-20">
        <Hero title={visibleTitle} />
        <AboutSection />
        <SkillsSection />
        <ProjectsSection />
        <ContactSection
          formValues={formValues}
          submitState={submitState}
          onChange={handleInputChange}
          onSubmit={handleSubmit}
        />
      </div>

      <footer className="relative z-10 border-t border-white/10 bg-background/50 py-8 backdrop-blur-md">
        <p className="text-center font-mono text-sm text-muted-foreground">
          © {new Date().getFullYear()} Sachin Lal. All systems nominal.
        </p>
      </footer>

      <Toast open={toastOpen} />
    </main>
  );
}
