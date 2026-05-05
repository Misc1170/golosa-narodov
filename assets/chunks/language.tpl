<div class="flex flex-col mx-30">
  <div class="grid grid-cols-12 text-white items-start">
    <div class="flex col-span-5 justify-end items-start flex-shrink-0">
    <!-- <div class="flex col-span-5 justify-end items-center"> -->
      <img class="h-[151px] w-[30px]" src="/assets/images/red-arrow-down.png" alt="">
      </svg>
      <div class="flex flex-col ml-10">
        <span class="uppercase font-bold text-[35px]">[[*pagetitle]]</span>
        <span class="text-[30px] font-light leading-none">сказки</span>
      </div>
    </div>

    <div class="col-span-2"></div>

    <div class="col-span-5 ml-10 mt-2">
      <span class="text-[17px] font-light leading-tight">[[*content:striptags]]</span>
    </div>
  </div>

  <div class="mt-20 flex flex-col gap-y-20">
    [[getImageList?
      &tvname=`audio_stories`
      &tpl=`audioStory`
    ]]
  </div>
</div>


<script>
const initApp = () => {
    // Находим все плееры на странице
    const allPlayers = Array.from(document.querySelectorAll('[data-audio-root]'));

    allPlayers.forEach((player, index) => {
        const audio = player.querySelector('[data-main-audio]');
        const playBtn = player.querySelector('[data-play-btn]');
        const playIcon = player.querySelector('.play-icon');
        const pauseIcon = player.querySelector('.pause-icon');
        const progress = player.querySelector('[data-progress]');
        const progressArea = player.querySelector('[data-progress-area]');
        const durationEl = player.querySelector('[data-duration]');
        const playerBar = player.querySelector('[data-player-bar]');
        const divider = player.querySelector('[data-divider]');
        const volumeCont = player.querySelector('[data-volume-cont]');
        const volumeBar = player.querySelector('[data-volume-bar]');
        const volumeProgress = player.querySelector('[data-volume-progress]');

        let isDraggingVolume = false;

        const formatTime = (s) => {
            if (!s || isNaN(s)) return '00:00';
            const min = Math.floor(s / 60);
            const sec = Math.floor(s % 60);
            return `${min.toString().padStart(2, '0')}:${sec.toString().padStart(2, '0')}`;
        };

        const updateDuration = () => {
            if (audio.duration && !isNaN(audio.duration)) {
                durationEl.textContent = formatTime(audio.duration);
            }
        };

        // Инициализация времени
        audio.addEventListener('loadedmetadata', updateDuration);
        if (audio.readyState >= 1) updateDuration();

        // --- PLAY / PAUSE ---
        playBtn.addEventListener('click', (e) => {
            e.stopPropagation();
            if (audio.paused) {
                // Останавливаем ВООБЩЕ ВСЕ аудио на странице
                document.querySelectorAll('audio').forEach(other => {
                    if (other !== audio) other.pause();
                });
                audio.play().catch(err => console.log("Ошибка запуска:", err));
            } else {
                audio.pause();
            }
        });

        // --- АВТОВОСПРОИЗВЕДЕНИЕ СЛЕДУЮЩЕГО ---
        audio.onended = () => {
            const next = allPlayers[index + 1];
            if (next) {
                const nextBtn = next.querySelector('[data-play-btn]');
                if (nextBtn) nextBtn.click();
            }
        };

        // --- ПЕРЕМОТКА (ТОЛЬКО ДЛЯ АКТИВНОГО) ---
        progressArea.addEventListener('click', (e) => {
            if (audio.paused) return;
            const rect = progressArea.getBoundingClientRect();
            const x = e.clientX - rect.left;
            audio.currentTime = (x / rect.width) * audio.duration;
        });

        // --- ГРОМКОСТЬ (DRAG) ---
        const moveVolume = (clientX) => {
            const rect = volumeBar.getBoundingClientRect();
            let vol = Math.max(0, Math.min(1, (clientX - rect.left) / rect.width));
            audio.volume = vol;
            volumeProgress.style.width = `${vol * 100}%`;
        };

        volumeBar.addEventListener('mousedown', (e) => {
            isDraggingVolume = true;
            moveVolume(e.clientX);
            document.body.style.userSelect = 'none';
        });

        window.addEventListener('mousemove', (e) => { if (isDraggingVolume) moveVolume(e.clientX); });
        window.addEventListener('mouseup', () => { 
            isDraggingVolume = false; 
            document.body.style.userSelect = ''; 
        });

        // --- ВИЗУАЛЬНЫЕ СОСТОЯНИЯ ---
        audio.onplay = () => {
            playIcon.classList.add('hidden');
            pauseIcon.classList.remove('hidden');
            playerBar.classList.replace('bg-orange-200', 'bg-gray-200');
            progress.classList.replace('bg-orange-500/30', 'bg-gray-500/50');
            divider.classList.replace('bg-orange-300', 'bg-gray-400');
            durationEl.classList.replace('text-orange-700', 'text-gray-600');
            playerBar.parentElement.classList.replace('flex-grow', 'w-[60%]');
            volumeCont.classList.replace('hidden', 'flex');
            progressArea.style.cursor = 'pointer';
        };

        audio.onpause = () => {
            playIcon.classList.remove('hidden');
            pauseIcon.classList.add('hidden');
            playerBar.classList.replace('bg-gray-200', 'bg-orange-200');
            progress.classList.replace('bg-gray-500/50', 'bg-orange-500/30');
            divider.classList.replace('bg-gray-400', 'bg-orange-300');
            durationEl.classList.replace('text-gray-600', 'text-orange-700');
            playerBar.parentElement.classList.replace('w-[60%]', 'flex-grow');
            volumeCont.classList.replace('flex', 'hidden');
            progressArea.style.cursor = 'default';
        };

        audio.ontimeupdate = () => {
            if (audio.duration) {
                progress.style.width = `${(audio.currentTime / audio.duration) * 100}%`;
            }
        };
    });
};

// Запуск после полной загрузки
if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', initApp);
} else {
    initApp();
}
</script>