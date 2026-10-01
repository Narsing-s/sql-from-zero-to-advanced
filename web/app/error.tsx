"use client";

import {useEffect} from "react";

export default function Error({error,reset}:{error:Error & {digest?:string};reset:()=>void}) {
  useEffect(()=>{console.error(error)},[error]);
  return (
    <main className="shell">
      <div className="container">
        <section className="card" style={{maxWidth:720,margin:"80px auto"}}>
          <div className="eyebrow">SQL Learning Hub</div>
          <h1>Something went wrong.</h1>
          <p className="muted">The learning workspace hit an unexpected error. Your browser-local progress is preserved.</p>
          <button className="btn primary" onClick={()=>reset()}>Try again</button>
        </section>
      </div>
    </main>
  );
}