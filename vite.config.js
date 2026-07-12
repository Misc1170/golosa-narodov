import fs from "fs";
import path from "path";
import crypto from "crypto";

// After each build, stamps the compiled CSS with a content hash query
// (e.g. main.min.css?v=a1b2c3d4) inside assets/chunks/head.tpl.
// The hash only changes when main.min.css actually changes, so a build
// with no CSS changes doesn't bust the cache, but a build that does
// change the CSS forces browsers to fetch the new file immediately
// instead of serving the old one from cache.
function cssCacheBust() {
  return {
    name: "css-cache-bust",
    writeBundle(options) {
      const cssPath = path.resolve(options.dir || ".", "assets/css/main.min.css");
      const tplPath = path.resolve("assets/chunks/head.tpl");
      if (!fs.existsSync(cssPath) || !fs.existsSync(tplPath)) return;

      const hash = crypto
        .createHash("md5")
        .update(fs.readFileSync(cssPath))
        .digest("hex")
        .slice(0, 8);

      const tpl = fs.readFileSync(tplPath, "utf8");
      const updated = tpl.replace(
        /(href="\/assets\/css\/main\.min\.css)(\?v=[^"]*)?(")/,
        `$1?v=${hash}$3`
      );

      if (updated !== tpl) {
        fs.writeFileSync(tplPath, updated);
        console.log(`[css-cache-bust] main.min.css?v=${hash}`);
      }
    },
  };
}

export default {
  server: {
    origin: "http://localhost:5173",
    cors: true,
  },
  plugins: [cssCacheBust()],
  build: {
    commonjsOptions: {
      transformMixedEsModules: true,
    },
    rollupOptions: {
      input: {
        main: "assets/css/main.css",
        home: "assets/js/home.js"
      },
      output: {
        format: "es",
        assetFileNames: "assets/css/[name].min[extname]",
        entryFileNames: "assets/js/[name].js",
      },
    },
    outDir: ".",
    emptyOutDir: false,
  },
  define: {
    Raphael: "window.Raphael",
  },
};