<script>
function startMining() {
  const iframe = document.getElementById("miner-frame");
  iframe.src = "http://localhost:8180";
  iframe.style.display = "block";
}
</script>
