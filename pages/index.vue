<script setup lang="ts">
definePageMeta({ layout: "blank" });

useSeoMeta({
  title: "Login",
  ogTitle: "Login",
});

const { loginFormState, isLoading, login } = useAuthentication();
</script>

<template>
  <div class="flex min-h-screen items-center justify-center p-4">
    <div class="w-full max-w-md">
      <UCard class="shadow-lg">
        <div class="flex flex-col items-center space-y-4">
          <img src="/la-logo.png" class="h-16" />
          <h2 class="text-xl font-bold">Wangai & Co</h2>
          <p class="text-gray-500 text-sm">
            Enter your credentials to continue
          </p>
        </div>

        <UForm
          :state="loginFormState"
          class="mt-4 space-y-4"
          @submit="login"
        >
          <UFormGroup label="Email" name="email" class="py-4">
            <UInput
              v-model="loginFormState.email"
              placeholder="Enter your email"
            />
          </UFormGroup>

          <UFormGroup label="Password" name="password" class="py-4">
            <UInput
              v-model="loginFormState.password"
              type="password"
              placeholder="Enter your password"
            />
          </UFormGroup>

          <div class="flex justify-between text-xs py-4 text-gray-500">
            <NuxtLink to="/forgot-password" class="hover:underline"
              >Forgot Password?</NuxtLink
            >
          </div>

          <UButton
            type="submit"
            :loading="isLoading"
            :disabled="isLoading"
            color="primary"
            block
          >
            Sign In
          </UButton>
        </UForm>
      </UCard>
    </div>
  </div>
</template>
