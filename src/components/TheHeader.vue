<template>
  <header class="site-header">
    <div class="container header-inner">
      <!-- Wordmark -->
      <div class="wordmark">
        <span class="wm-icon" aria-hidden="true">
          <svg width="34" height="34" viewBox="0 0 34 34" fill="none" xmlns="http://www.w3.org/2000/svg">
            <rect width="34" height="34" rx="8" fill="#1b4332"/>
            <!-- stylised water-drop + wheat -->
            <path d="M17 6 C17 6, 10 15, 10 20 a7 7 0 0 0 14 0 C24 15, 17 6, 17 6Z" fill="#74c69d"/>
            <line x1="17" y1="20" x2="17" y2="28" stroke="#d8f3dc" stroke-width="1.6" stroke-linecap="round"/>
            <line x1="17" y1="23" x2="20" y2="20" stroke="#d8f3dc" stroke-width="1.4" stroke-linecap="round"/>
            <line x1="17" y1="25.5" x2="14" y2="23" stroke="#d8f3dc" stroke-width="1.4" stroke-linecap="round"/>
          </svg>
        </span>
        <div class="wm-text">
          <span class="wm-main">AWM-Bench</span>
          <span class="wm-sub">Agricultural Water Management AI</span>
        </div>
      </div>

      <!-- Nav links -->
      <nav class="header-nav" aria-label="Site navigation">
        <a href="#leaderboard" class="nav-link">Leaderboard</a>
        <a href="#benchmarks" class="nav-link">Papers &amp; Cite</a>
        <a href="#submit" class="nav-link">Submit</a>
          <a
          href="https://github.com/MSU-CECO"
          target="_blank"
          rel="noopener"
          class="btn btn-outline btn-sm hide-mobile"
          aria-label="GitHub organisation"
        >
          <svg width="15" height="15" viewBox="0 0 16 16" fill="currentColor"><path d="M8 0C3.58 0 0 3.58 0 8c0 3.54 2.29 6.53 5.47 7.59.4.07.55-.17.55-.38 0-.19-.01-.82-.01-1.49-2.01.37-2.53-.49-2.69-.94-.09-.23-.48-.94-.82-1.13-.28-.15-.68-.52-.01-.53.63-.01 1.08.58 1.23.82.72 1.21 1.87.87 2.33.66.07-.52.28-.87.51-1.07-1.78-.2-3.64-.89-3.64-3.95 0-.87.31-1.59.82-2.15-.08-.2-.36-1.02.08-2.12 0 0 .67-.21 2.2.82.64-.18 1.32-.27 2-.27.68 0 1.36.09 2 .27 1.53-1.04 2.2-.82 2.2-.82.44 1.1.16 1.92.08 2.12.51.56.82 1.27.82 2.15 0 3.07-1.87 3.75-3.65 3.95.29.25.54.73.54 1.48 0 1.07-.01 1.93-.01 2.2 0 .21.15.46.55.38A8.013 8.013 0 0016 8c0-4.42-3.58-8-8-8z"/></svg>
          MSU-CECO
        </a>
      </nav>
    </div>
  </header>
</template>

<style scoped>
.site-header {
  position: sticky; top: 0; z-index: 50;
  background: rgba(247,246,241,.92);
  backdrop-filter: blur(12px);
  border-bottom: 1px solid var(--border);
}
.header-inner {
  display: flex; align-items: center; justify-content: space-between;
  height: 62px; gap: 1rem;
}
.wordmark {
  display: flex; align-items: center; gap: .75rem;
  text-decoration: none; color: inherit;
  flex-shrink: 0;
}
.wm-icon { display: flex; flex-shrink: 0; }
.wm-text { display: flex; flex-direction: column; line-height: 1.2; }
.wm-main {
  font-family: var(--font-display);
  font-size: 1.15rem; font-weight: 700;
  color: var(--green-deep); letter-spacing: -.015em;
}
.wm-sub {
  font-size: .68rem; color: var(--ink-3);
  letter-spacing: .02em; text-transform: uppercase;
  font-family: var(--font-body); font-weight: 500;
}
.header-nav { display: flex; align-items: center; gap: .25rem; }
.nav-link {
  padding: .4rem .75rem;
  font-size: .875rem; font-weight: 500;
  color: var(--ink-2);
  border-radius: var(--radius);
  transition: var(--transition);
  text-decoration: none;
}
.nav-link:hover { background: var(--green-pale); color: var(--green-deep); text-decoration: none; }
.btn-sm { padding: .38rem .85rem; font-size: .8rem; }

@media (max-width: 520px) {
  .wm-sub { display: none; }
  .nav-link { padding: .4rem .5rem; font-size: .8rem; }
}
</style>
