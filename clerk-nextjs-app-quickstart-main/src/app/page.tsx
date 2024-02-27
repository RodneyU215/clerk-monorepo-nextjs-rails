'use client';
import { UserButton } from '@clerk/nextjs';
import { getUserData } from './actions';
import { useState } from 'react';

export default function Home() {
  const [userData, setUserData] = useState(null);

  const getData = async () => {
    const data = await getUserData();
    setUserData(data);
  };

  return (
    <div className="h-full">
      <UserButton afterSignOutUrl="/" />
      <div className="h-screen">
        <button onClick={getData}>Get Backend User Data</button>
        {userData && <pre>{JSON.stringify(userData, null, 2)}</pre>}
      </div>
    </div>
  );
}
