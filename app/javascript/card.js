document.addEventListener("turbo:load", () => {
  const cards = document.querySelectorAll(".quiz-card");
  const button = document.getElementById("next-button");
  const progressBar = document.getElementById("progress-bar");
  const remainingText = document.getElementById("remaining-count");

  if (!button) return;
// 進捗制御と
  let current = 0;
  const total = cards.length;

  updateProgress();
// 思い出したクリック
  button.addEventListener("click", async () => {

  const currentCard = cards[current];
  const reviewId = currentCard.dataset.reviewId;
// railsのraviews#updateを呼ぶ
  await fetch(`/reviews/${reviewId}`, {
    method: "PATCH",
    headers: {
      "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').content,
      "Content-Type": "application/json"
    }
  });
// カード隠す
  currentCard.classList.add("hidden");
// 次カード
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
// 終了画面
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
          おつかれさま！！👏
        </h2>
        <p class="text-slate-400 mb-6 leading-relaxed">
          次の復習タイミングをお楽しみに🎓
        </p>

        <a href="/learnings/new"
          class="inline-block bg-indigo-600 text-white px-6 py-3 rounded-xl font-bold">
          もっと覚える
        </a>
      </div>
    `;
  }

  const keywords = document.querySelectorAll(".keyword-toggle");

  keywords.forEach((el) => {
    el.addEventListener("click", () => {
      const answer = el.dataset.answer;

      // すでに表示済みなら何もしない
      if (el.dataset.opened === "true") return;

      el.innerText = answer;
      el.classList.remove("text-slate-400");
      el.classList.add("text-indigo-400", "font-bold");

      el.dataset.opened = "true";
    });
  });
});