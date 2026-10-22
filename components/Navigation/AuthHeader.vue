<script setup lang="ts">
const navLinks = [
  { name: "Shop", path: "https://shop.Muhoho-Lawcraft.com/" },
  { name: "Website", path: "https://Muhoho-Lawcraft.com/" },
];

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
  <header
    class="flex flex-wrap md:justify-start md:flex-nowrap z-50 w-full text-sm fixed top-0"
  >
    <nav
      class="mt-6 relative max-w-[85rem] w-full bg-white border border-gray-200 rounded-xl md:rounded-[36px] mx-2 py-3 px-4 flex items-center gap-2 md:justify-between md:px-6 lg:px-8 xl:mx-auto dark:bg-gray-900 dark:border-gray-800"
      aria-label="Global"
    >
      <!-- Logo -->
      <NuxtLink
        class="flex-none gap-3 font-semibold flex items-center dark:text-white"
        to="/"
        aria-label="Brand"
      >
        <img src="/la-logo.png" class="h-[50px]" />
        <p class="text-sm leading-tight hidden md:block">Wangai-Law</p>
      </NuxtLink>

      <!-- Navigation Links -->
      <div id="navbar-collapse" class="hs-collapse md:block">
        <div class="flex items-center justify-end gap-x-7 md:ps-7">
          <!-- <div class="flex gap-x-7">
            <NuxtLink
              v-for="link in navLinks"
              :key="link.path"
              class="font-medium md:py-6"
              :class="{ 'text-primary': $route.path === link.path }"
              :to="link.path"
            >
              {{ link.name }}
            </NuxtLink>
          </div> -->

          <!-- Theme Switcher Button -->
          <button
            class="flex items-center gap-2 p-2 rounded-lg transition hover:bg-primary/10"
            @click="toggleTheme"
          >
          <Icon :name="currentTheme?.icon || 'mdi:white-balance-sunny'" class="w-5 h-5" />
          <span>{{ currentTheme?.label }}</span>
          </button>
        </div>
      </div>
    </nav>
  </header>
</template>
