"use client";

type SplineStageProps = {
  scene?: string;
};

export function SplineStage({ scene }: SplineStageProps) {
  if (!scene) {
    return (
      <div className="relative min-h-[460px] overflow-hidden rounded-[1.5rem] bg-[radial-gradient(circle_at_top,rgba(142,255,215,0.18),transparent_24%),radial-gradient(circle_at_bottom_right,rgba(255,191,130,0.16),transparent_28%),linear-gradient(180deg,#0f171f_0%,#0a0f15_100%)]">
        <div className="absolute inset-0 bg-[linear-gradient(rgba(255,255,255,0.04)_1px,transparent_1px),linear-gradient(90deg,rgba(255,255,255,0.04)_1px,transparent_1px)] bg-[size:42px_42px] opacity-30" />
        <div className="absolute left-6 top-6 rounded-[1.2rem] border border-white/10 bg-black/35 px-4 py-3 text-xs font-semibold uppercase tracking-[0.24em] text-[#8effd7]">
          Product preview
        </div>

        <div className="absolute left-5 top-24 hidden w-44 rounded-[1.4rem] border border-white/10 bg-[#111922]/88 p-4 text-sm text-white/68 md:block">
          <p className="font-semibold text-white">KYC verified</p>
          <p className="mt-2 leading-6">
            OTP, identity flows, and secure reward access.
          </p>
        </div>

        <div className="absolute bottom-8 right-6 hidden w-48 rounded-[1.4rem] border border-white/10 bg-[#17111a]/92 p-4 text-sm text-white/68 md:block">
          <p className="font-semibold text-white">Points ledger</p>
          <p className="mt-2 leading-6">
            Transactions, rewards, and redemption logic in one place.
          </p>
        </div>

        <div className="relative z-10 flex h-full min-h-[460px] items-center justify-center px-6 py-16">
          <div className="w-full max-w-[270px] rounded-[2.8rem] border border-white/12 bg-[#050a0f] p-3 shadow-[0_40px_100px_rgba(0,0,0,0.55)]">
            <div className="rounded-[2.2rem] border border-white/8 bg-[linear-gradient(180deg,#131e28,#0d1319)] p-4">
              <div className="mx-auto mb-5 h-1.5 w-20 rounded-full bg-white/10" />
              <div className="rounded-[1.6rem] border border-[#8effd7]/18 bg-[linear-gradient(180deg,rgba(142,255,215,0.16),rgba(142,255,215,0.03))] p-4">
                <p className="text-[11px] uppercase tracking-[0.22em] text-[#8effd7]">
                  Shubh Mangal
                </p>
                <p className="mt-3 text-3xl font-semibold text-white">12,480</p>
                <p className="mt-1 text-sm text-white/58">Available reward points</p>
                <div className="mt-5 grid gap-3">
                  <div className="rounded-2xl border border-white/8 bg-black/25 px-4 py-3">
                    <p className="text-xs uppercase tracking-[0.2em] text-white/42">
                      Campaign
                    </p>
                    <p className="mt-2 text-white">Sarvottam Active</p>
                  </div>
                  <div className="rounded-2xl border border-white/8 bg-black/25 px-4 py-3">
                    <p className="text-xs uppercase tracking-[0.2em] text-white/42">
                      Status
                    </p>
                    <p className="mt-2 text-white">KYC completed</p>
                  </div>
                </div>
              </div>

              <div className="mt-4 grid grid-cols-3 gap-2">
                <div className="rounded-xl bg-white/7 px-3 py-3 text-center text-xs text-white/62">
                  OTP
                </div>
                <div className="rounded-xl bg-white/7 px-3 py-3 text-center text-xs text-white/62">
                  API
                </div>
                <div className="rounded-xl bg-white/7 px-3 py-3 text-center text-xs text-white/62">
                  BLoC
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    );
  }

  return (
    <div className="h-full min-h-[360px] overflow-hidden rounded-[2rem] border border-white/10 bg-black/30">
      <iframe
        title="Spline 3D scene"
        src={scene}
        className="h-full min-h-[360px] w-full"
        allow="fullscreen; xr-spatial-tracking"
      />
    </div>
  );
}
