export default {
  server: {
    origin: "http://localhost:5173",
    cors: true,
  },
  build: {
    commonjsOptions: {
      transformMixedEsModules: true,
    },
    rollupOptions: {
      input: {
        main: "assets/css/main.css",
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