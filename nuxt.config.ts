export default defineNuxtConfig({
  devtools: { enabled: true },

  app: {
    head: {
      titleTemplate: (titleChunk) => {
        return titleChunk
          ? `${titleChunk} | Wangai & Co`
          : "Wangai & Co";
      },
    },
  },

  buildModules: ["@nuxtjs/dotenv"],

  ssr: false,

  css: ["@/assets/scss/index.scss", "@/assets/css/tailwind.css"],

  ui: {
    icons: ["lucide"],
  },

  supabase: {
    redirect: false,
    url: process.env.NUXT_SUPABASE_URL || "https://baiklnypvrekcxkmdfsu.supabase.co",
    key: process.env.NUXT_SUPABASE_ANON_KEY,
    serviceKey: process.env.NUXT_SUPABASE_SERVICE_ROLE_KEY,
  },

  runtimeConfig: {
    public: {
      APP_URL: process.env.APP_URL,
      supabaseUrl: process.env.NUXT_SUPABASE_URL || "https://baiklnypvrekcxkmdfsu.supabase.co",
      supabaseAnonKey: process.env.NUXT_SUPABASE_ANON_KEY,
      supabaseServiceRoleKey: process.env.NUXT_SUPABASE_SERVICE_ROLE_KEY,
      port: process.env.NUXT_PORT,
    },
  },

  modules: [
    "@nuxt/ui",
    "@nuxtjs/color-mode",
    "@vueuse/nuxt",
    "@nuxtjs/supabase",
  ],

  compatibilityDate: "2025-03-08",
});
