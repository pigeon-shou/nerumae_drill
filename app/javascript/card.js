document.addEventListener("turbo:load", () => {
  const cards = document.querySelectorAll(".quiz-card");
  const button = document.getElementById("next-button");
  const progressBar = document.getElementById("progress-bar");
  const remainingText = document.getElementById("remaining-count");

  if (!button) return;

  let current = 0;
  const total = cards.length;

  updateProgress();

  button.addEventListener("click", () => {
    cards[current].classList.add("hidden");

    current++;

    if (current < total) {
      cards[current].classList.remove("hidden");
      updateProgress();
    } else {
      showFinish();
    }
  });

  function updateProgress() {
    const progress = (current / total) * 100;
    progressBar.style.width = `${progress}%`;
    remainingText.innerText = total - current;
  }

  function showFinish() {
    const container = document.getElementById("quiz-container");

    if (button) {
    button.remove();
    }
    
    progressBar.style.width = "100%";
    remainingText.innerText = "0";

    container.innerHTML = `
      <div class="text-center mt-20">
        <h2 class="text-3xl font-bold text-white mb-4">
          おつかれさま！！
        </h2>
        <p class="text-slate-400 mb-6">
          今日の復習、完璧です👏
        </p>

        <button onclick="location.reload()"
          class="bg-indigo-600 text-white px-6 py-3 rounded-xl font-bold">
          もう一度やる
        </button>
      </div>
    `;
  }
});