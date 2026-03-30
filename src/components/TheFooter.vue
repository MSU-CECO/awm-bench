<template>
  <footer class="site-footer">
    <div class="container footer-inner">
      <div class="footer-left">
        <span class="footer-brand">AWM-Bench</span>
        <span class="footer-sep" aria-hidden="true">·</span>
        <span class="footer-affil">from CECO/DSI Labs at MSU</span>
      </div>
      <div class="footer-links">
        <a href="https://huggingface.co/msu-ceco" target="_blank" rel="noopener">🤗 Datasets</a>
      </div>
      <div class="footer-right">
        <span class="footer-note">
          Data sourced from peer-reviewed papers.
        </span>
      </div>
    </div>
  </footer>
</template>

<style scoped>
.site-footer {
  background: var(--green-deep); color: rgba(255,255,255,.75);
  padding: 2rem 0;
  margin-top: 4rem;
}
.footer-inner {
  display: flex; align-items: center; flex-wrap: wrap;
  gap: 1rem; justify-content: space-between;
}
.footer-brand {
  font-family: var(--font-display); font-weight: 700; font-size: 1rem;
  color: #fff;
}
.footer-sep { color: rgba(255,255,255,.35); }
.footer-affil { font-size: .82rem; }
.footer-affil a, .footer-links a, .footer-note a {
  color: var(--green-light); text-decoration: none;
}
.footer-affil a:hover, .footer-links a:hover, .footer-note a:hover {
  color: #fff; text-decoration: underline;
}
.footer-links { display: flex; flex-wrap: wrap; gap: 1rem; font-size: .82rem; }
.footer-right { font-size: .78rem; max-width: 280px; text-align: right; }
.footer-note { line-height: 1.5; }

@media (max-width: 768px) {
  .footer-right { text-align: left; max-width: none; }
}
</style>
