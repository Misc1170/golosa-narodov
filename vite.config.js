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
      output: {
        format: "es", // или попробуйте 'cjs' если проект старый
      },
    },
  },
  define: {
    Raphael: "window.Raphael",
  },
};
