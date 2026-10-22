<script setup lang="ts">
import { useAuthentication } from "~/composables/useAuthentication";

definePageMeta({ layout: "blank" });

useSeoMeta({
  title: "Register",
  ogTitle: "Register",
});

const { registerFormState, isLoading, register } = useAuthentication();
</script>

<template>
  <div class="flex min-h-screen items-center justify-center p-4">
    <div class="w-full max-w-md">
      <UCard class="shadow-lg">
        <div class="flex flex-col items-center space-y-4">
          <img src="/la-logo.png" class="h-16" />
          <h2 class="text-xl font-bold">
            Welcome to Wangai & Co
          </h2>
          <p class="text-gray-500 text-sm">Enter your details to continue</p>
        </div>

        <UForm
          :state="registerFormState"
          class="mt-4 space-y-4"
          @submit="register"
        >
          <UFormGroup label="Full name" name="full_name" class="py-4">
            <UInput
              v-model="registerFormState.full_name"
              placeholder="Enter your full name"
            />
          </UFormGroup>

          <UFormGroup label="Email" name="email" class="py-4">
            <UInput
              v-model="registerFormState.email"
              placeholder="Enter your email"
            />
          </UFormGroup>

          <UFormGroup label="Phone number" name="phone_number" class="py-4">
            <UInput
              v-model="registerFormState.phone_number"
              placeholder="Enter your phone number"
            />
          </UFormGroup>

          <UFormGroup label="Password" name="password" class="py-4">
            <UInput
              v-model="registerFormState.password"
              type="password"
              placeholder="Enter your password"
            />
          </UFormGroup>

          <UFormGroup
            label="Confirm Password"
            name="confirm_password"
            class="py-4"
          >
            <UInput
              v-model="registerFormState.confirmPassword"
              type="password"
              placeholder="Enter your password again"
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
            Sign Up
          </UButton>
        </UForm>
      </UCard>
    </div>
  </div>
</template>
