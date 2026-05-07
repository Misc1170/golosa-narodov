<div class="flex flex-col mx-30 my-20">
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
(function() {
    // Глобальная переменная для хранения уровня громкости (от 0 до 1)
    let globalVolume = 1;

    const initAudioSystem = () => {
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
            const volumeCont = player.querySelector('[data-volume-cont]');
            const volumeBar = player.querySelector('[data-volume-bar]');
            const volumeProgress = player.querySelector('[data-volume-progress]');
            const baseColor = playBtn.getAttribute('data-base-color');
            const darkBaseColor = baseColor.replace('/70', '');

            let isDraggingVolume = false;

            const formatTime = (s) => {
                if (!s || isNaN(s)) return '00:00';
                const min = Math.floor(s / 60);
                const sec = Math.floor(s % 60);
                return `${min.toString().padStart(2, '0')}:${sec.toString().padStart(2, '0')}`;
            };

            const updateTimeDisplay = () => {
                if (audio.currentTime > 0) {
                    durationEl.textContent = formatTime(audio.currentTime);
                } else {
                    durationEl.textContent = formatTime(audio.duration);
                }
            };

            // Функция синхронизации громкости во всех плеерах
            const syncGlobalVolume = (newVolume) => {
                globalVolume = newVolume;
                document.querySelectorAll('[data-audio-root]').forEach(p => {
                    const a = p.querySelector('[data-main-audio]');
                    const vProg = p.querySelector('[data-volume-progress]');
                    if (a) a.volume = globalVolume;
                    if (vProg) vProg.style.width = `${globalVolume * 100}%`;
                });
            };

            audio.addEventListener('loadedmetadata', updateTimeDisplay);
            if (audio.readyState >= 1) updateTimeDisplay();

            // Устанавливаем начальную громкость при загрузке
            syncGlobalVolume(globalVolume);

            playBtn.addEventListener('click', (e) => {
                e.stopPropagation();
                if (audio.paused) {
                    document.querySelectorAll('audio').forEach(otherAudio => {
                        if (otherAudio !== audio) {
                            otherAudio.pause();
                            otherAudio.currentTime = 0;
                            const otherPlayer = otherAudio.closest('[data-audio-root]');
                            if (otherPlayer) {
                                const otherBtn = otherPlayer.querySelector('[data-play-btn]');
                                const otherDuration = otherPlayer.querySelector('[data-duration]');
                                if (otherBtn) {
                                    const otherBase = otherBtn.getAttribute('data-base-color');
                                    otherBtn.classList.replace(otherBase.replace('/70', ''), otherBase);
                                }
                                if (otherAudio.duration) otherDuration.textContent = formatTime(otherAudio.duration);
                            }
                        }
                    });
                    audio.play().catch(err => console.log("Ошибка запуска:", err));
                } else {
                    audio.pause();
                }
            });

            audio.onended = () => {
                const next = allPlayers[index + 1];
                if (next) {
                    const nextBtn = next.querySelector('[data-play-btn]');
                    if (nextBtn) nextBtn.click();
                }
            };

            progressArea.addEventListener('click', (e) => {
                if (!audio.paused || audio.currentTime > 0) {
                    const rect = progressArea.getBoundingClientRect();
                    const x = e.clientX - rect.left;
                    audio.currentTime = (x / rect.width) * audio.duration;
                    updateTimeDisplay();
                }
            });

            const moveVolume = (clientX) => {
                const rect = volumeBar.getBoundingClientRect();
                let vol = Math.max(0, Math.min(1, (clientX - rect.left) / rect.width));
                syncGlobalVolume(vol); // Вызываем синхронизацию для всех
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

            audio.onplay = () => {
                playIcon.classList.add('hidden');
                pauseIcon.classList.remove('hidden');
                playerBar.parentElement.classList.replace('flex-grow', 'w-[60%]');
                volumeCont.classList.replace('hidden', 'flex');
                progressArea.style.cursor = 'pointer';
                playBtn.classList.replace(baseColor, darkBaseColor);
                // При запуске убеждаемся, что громкость актуальна
                audio.volume = globalVolume;
            };

            audio.onpause = () => {
                playIcon.classList.remove('hidden');
                pauseIcon.classList.add('hidden');
                playerBar.parentElement.classList.replace('w-[60%]', 'flex-grow');
                volumeCont.classList.replace('flex', 'hidden');
                
                if (audio.currentTime === 0) {
                    progress.style.width = '0%';
                    progressArea.style.cursor = 'default';
                    durationEl.textContent = formatTime(audio.duration);
                } else {
                    progressArea.style.cursor = 'pointer';
                    durationEl.textContent = formatTime(audio.currentTime);
                }
            };

            audio.ontimeupdate = () => {
                if (audio.duration) {
                    progress.style.width = `${(audio.currentTime / audio.duration) * 100}%`;
                    if (audio.currentTime > 0) durationEl.textContent = formatTime(audio.currentTime);
                }
            };
        });
    };

    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', initAudioSystem);
    } else {
        initAudioSystem();
    }
})();
</script>