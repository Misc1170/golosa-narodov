<div class="flex gap-8 items-start w-full mb-16">
    <!-- КАРТИНКА -->
    [[+image:notempty=`
    <div class="w-1/3 max-w-[300px] flex-shrink-0">
        <img src="[[+image]]" alt="[[+name_1]]" class="w-[149px] h-[149px] rounded-2xl object-cover shadow-md">
    </div>
    `]]

    <div class="flex flex-col gap-6 flex-grow">
        <!-- ПЕРВОЕ АУДИО (file_1) -->
        [[+file_1:notempty=`
        <div class="audio-container w-full" data-audio-root>
            <div class="flex flex-col justify-between mb-2">
                <h3 class="text-lg font-bold text-gray-800">[[+name_1]]</h3>
                <span class="text-[10px] uppercase tracking-widest text-gray-400 font-bold">
                    [[+is_original_1:is=`1`:then=`Оригинал`:else=`Перевод`]]
                </span>
            </div>
            <div class="flex items-center w-full transition-all duration-500 ease-in-out gap-4">
                <div class="relative flex items-center h-10 bg-orange-200 rounded-full flex-grow transition-all duration-500 overflow-hidden" data-player-bar>
                    <div class="relative z-20 flex items-center h-full">
                        <button class="pl-4 pr-3 h-full flex items-center justify-center cursor-pointer hover:opacity-80" data-play-btn>
                            <div class="play-icon border-l-[12px] border-l-orange-600 border-y-[8px] border-y-transparent ml-1"></div>
                            <div class="pause-icon hidden flex gap-1"><div class="w-1.5 h-4 bg-orange-600"></div><div class="w-1.5 h-4 bg-orange-600"></div></div>
                        </button>
                        <div class="w-[1px] h-6 bg-orange-300" data-divider></div>
                    </div>
                    <div class="relative flex-grow h-full cursor-pointer flex items-center px-3" data-progress-area>
                        <span class="relative z-10 text-sm font-mono text-orange-700" data-duration>00:00</span>
                        <div class="absolute top-0 left-0 h-full bg-orange-500/30 pointer-events-none transition-all duration-100" data-progress style="width: 0%"></div>
                    </div>
                    <audio src="[[+file_1]]" data-main-audio preload="metadata"></audio>
                </div>
                <div class="hidden items-center gap-2 w-32 animate-fade-in" data-volume-cont>
                    <div class="relative w-full h-1.5 bg-gray-300 rounded-full overflow-hidden cursor-pointer touch-none" data-volume-bar>
                        <div class="absolute top-0 left-0 h-full bg-gray-600 pointer-events-none" data-volume-progress style="width: 100%"></div>
                    </div>
                </div>
            </div>
        </div>
        `]]

        <!-- ВТОРОЕ АУДИО (file_2) -->
        [[+file_2:notempty=`
        <div class="audio-container w-full" data-audio-root>
            <div class="flex flex-col justify-between mb-2">
                <h3 class="text-lg font-bold text-gray-800">[[+name_2]]</h3>
                <span class="text-[10px] uppercase tracking-widest text-gray-400 font-bold">
                    [[+is_original_2:is=`1`:then=`Оригинал`:else=`Перевод`]]
                </span>
            </div>
            <div class="flex items-center w-full transition-all duration-500 ease-in-out gap-4">
                <div class="relative flex items-center h-10 bg-orange-200 rounded-full flex-grow transition-all duration-500 overflow-hidden" data-player-bar>
                    <div class="relative z-20 flex items-center h-full">
                        <button class="pl-4 pr-3 h-full flex items-center justify-center cursor-pointer hover:opacity-80" data-play-btn>
                            <div class="play-icon border-l-[12px] border-l-orange-600 border-y-[8px] border-y-transparent ml-1"></div>
                            <div class="pause-icon hidden flex gap-1"><div class="w-1.5 h-4 bg-orange-600"></div><div class="w-1.5 h-4 bg-orange-600"></div></div>
                        </button>
                        <div class="w-[1px] h-6 bg-orange-300" data-divider></div>
                    </div>
                    <div class="relative flex-grow h-full cursor-pointer flex items-center px-3" data-progress-area>
                        <span class="relative z-10 text-sm font-mono text-orange-700" data-duration>00:00</span>
                        <div class="absolute top-0 left-0 h-full bg-orange-500/30 pointer-events-none transition-all duration-100" data-progress style="width: 0%"></div>
                    </div>
                    <audio src="[[+file_2]]" data-main-audio preload="metadata"></audio>
                </div>
                <div class="hidden items-center gap-2 w-32 animate-fade-in" data-volume-cont>
                    <div class="relative w-full h-1.5 bg-gray-300 rounded-full overflow-hidden cursor-pointer touch-none" data-volume-bar>
                        <div class="absolute top-0 left-0 h-full bg-gray-600 pointer-events-none" data-volume-progress style="width: 100%"></div>
                    </div>
                </div>
            </div>
        </div>
        `]]
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