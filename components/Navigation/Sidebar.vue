<script setup lang="ts">
import { admin, lawyer, client } from "./SidebarItems";

defineProps<{ isOpen: boolean }>();

const emit = defineEmits(["toggle"]);

const router = useRouter();

const { auth: authAction } = useSupabaseClient();

const userRole = useHashedCookie<string | null | undefined>("aa05f44d53a34");

// userRole.value = 'admin'

const getSidebarItems = (role: string | null | undefined) => {
  switch (role) {
    case "admin":
      return admin;
    case "lawyer":
      return lawyer;
    case "client":
      return client;
    default:
      return []; // Empty array if role is not recognized
  }
};

const sidebarItems = computed(() => getSidebarItems(userRole.value));
</script>

<template>
  <aside
    class="fixed inset-y-0 left-0 h-screen border-r p-4 transition-all duration-300 ease-in-out overflow-y-auto"
    :class="[
      isOpen ? 'w-64' : 'w-20',
      'bg-background dark:bg-stone-800', // Background color for both modes
      'border-r dark:border-stone-700', // Border color for dark mode
    ]"
    style="z-index: 200"
  >
    <!-- Logo & Title -->
    <NuxtLink to="/dashboard" class="flex items-center gap-2 mb-6">
      <img src="/la-logo.png" class="h-12" />
      <span
        class="text-lg font-semibold transition-opacity duration-200"
        :class="isOpen ? 'opacity-100' : 'opacity-0'"
      >
        Wangai & Co
      </span>
    </NuxtLink>

    <!-- Navigation Items -->
    <div class="flex-1 overflow-y-auto mb-6">
      <div v-for="section in sidebarItems" :key="section.section" class="mb-6">
        <!-- Hide section titles if sidebar is collapsed -->
        <p v-if="isOpen" class="text-xs font-bold mb-2 text-gray-500 uppercase">
          {{ section.section }}
        </p>
        <div class="space-y-1">
          <NuxtLink
            v-for="link in section.items"
            :key="link.to"
            :to="link.to"
            class="flex items-center gap-3 px-4 py-2 rounded-lg transition duration-200"
            :class="[
              $route.path === link.to
                ? 'bg-primary text-white'
                : 'hover:bg-primary/10 dark:hover:bg-stone-700 dark:hover:text-white hover:text-primary',
              'text-gray-700 dark:text-gray-300',
            ]"
          >
            <Icon :name="link.icon" class="w-5 h-5 flex-shrink-0" />
            <!-- Always show label -->
            <span
              class="transition-opacity duration-200"
              :class="isOpen ? 'opacity-100' : 'opacity-0 hidden'"
            >
              {{ link.label }}
            </span>
          </NuxtLink>
        </div>
      </div>
    </div>
  </aside>
</template>
