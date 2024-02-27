'use server';
import { auth } from '@clerk/nextjs';
import { redirect } from 'next/navigation';

export const getUserData = async () => {
  const { userId, getToken } = auth();
  const token = await getToken();
  if (!userId) {
    redirect('/sign-in');
  }
  const res = await fetch(`http://0.0.0.0:3000/current_user`, {
    method: 'GET',
    headers: {
      'Content-Type': 'application/json',
      Authorization: `Bearer ${token}`,
    },
  });
  console.log(res);
  const userData = await res.json();
  console.log(userData);
  return userData;
};
