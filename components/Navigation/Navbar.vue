<script setup lang="ts">
const emit = defineEmits(["toggleSidebar", "openSearch"]);

const { auth: authAction } = useSupabaseClient();

const router = useRouter();

const signOut = async () => {
  // await logout();
  router.push("/");
};

// Theme options
const themes = [
  { value: "light", label: "Light", icon: "mdi:white-balance-sunny" },
  { value: "dark", label: "Dark", icon: "mdi:weather-night" },
];

const colorMode = useColorMode();

// Find current theme
const currentTheme = computed(() =>
  themes.find((theme) => theme.value === colorMode.preference)
);

// Toggle theme when button clicked
const toggleTheme = () => {
  colorMode.preference = colorMode.preference === "light" ? "dark" : "light";
};
</script>

<template>
  <nav
    class="bg-background border-b dark:border-stone-800 px-6 py-4 flex flex-nowrap items-center justify-between w-full box-border overflow-x-hidden relative"
  >
    <div class="flex-1 flex items-center gap-2">
      <img src="/la-logo.png" class="h-8" />
      <span class="font-semibold">Wangai-Law</span>
    </div>

    <!-- Theme Switcher Button -->
    <button
      class="flex items-center gap-2 p-2 rounded-lg transition hover:bg-primary/10"
      @click="toggleTheme"
    >
      <Icon
        :name="currentTheme?.icon || 'mdi:white-balance-sunny'"
        class="w-5 h-5"
      />
    </button>
  </nav>
</template>

<style scoped>
.navbar {
  overflow-x: hidden;
  box-sizing: border-box;
}
</style>

<style scoped>
.navbar {
  background-color: var(--background);
  border-bottom: 1px solid var(--border-color);
  padding: 1rem 1.5rem;
  display: flex;
  flex-wrap: nowrap; /* Keep items on one line */
  align-items: center;
  justify-content: space-between;
  width: 100%;
  overflow-x: hidden;
  box-sizing: border-box;
}
.actions {
  flex-shrink: 0;
}
</style>
