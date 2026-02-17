contract.on("Transfer", (from, to, value) => {
  console.log(`Transfer detected: ${from} -> ${to} | ${value}`);
});
