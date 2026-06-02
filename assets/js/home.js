import RussianMap from "./russian-map.js";
import regionsData from "./region-without-languages.json";

window.RussianMap = RussianMap;

window.onload = function () {
  const data = regionsData;

  new RussianMap(
    {
      viewPort: data.viewPort,
      mapId: "russian-map",
      width: 975,
      height: 497,
      defaultAttr: {
        fill: "#90979C",
        "fill-opacity": 1,
        stroke: "#000000",
        "stroke-width": 1,
      },
      mouseMoveAttr: {
        fill: "#FFFFFF",
        "stroke-width": 2,
      },
      mouseClickAttr: {
        fill: "#FFFFFF",
        stroke: "#FFB35B",
        "stroke-width": 2,
      },
      onMouseClick: function (event) {
        const activeRegions = window.activeRegions;
        const avtiveRegion = activeRegions.find(
          (item) => item.region_id === this.region.ident,
        );

        let html = `<strong>${this.region.name}</strong>`;
        if (avtiveRegion) {
          avtiveRegion.languages.forEach((language) => {
            html += `<a href="${language.link}"
                                   class="cursor-pointer hover:underline lowercase">
                                   ${language.name}
                                 </a>`;
          });
        }
        const label = document.getElementById("region-label");
        label.innerHTML = html;

        label.style.left = event.pageX + "px";
        label.style.top = event.pageY + "px";

        label.style.display = "flex";
        label.style.flexDirection = "column";
      },
    },
    data.regions,
  );

  // Масштабирование карты под ширину контейнера без переноса элементов
  const MAP_W = 975;
  const MAP_H = 497;

  function scaleMap() {
    const mapEl = document.getElementById("russian-map");
    if (!mapEl) return;
    const wrapper = mapEl.parentElement;

    // documentElement.clientWidth — всегда реальная ширина viewport, не зависит от контента
    const availW = document.documentElement.clientWidth;
    const scale = Math.min(1, availW / MAP_W);

    if (scale < 1) {
      mapEl.style.transformOrigin = "top left";
      mapEl.style.transform = `scale(${scale})`;
      // Явно задаём размер обёртки = визуальный размер карты,
      // иначе layout всё равно резервирует 975px
      wrapper.style.width = Math.round(MAP_W * scale) + "px";
      wrapper.style.height = Math.round(MAP_H * scale) + "px";
      wrapper.style.overflow = "hidden";
    } else {
      mapEl.style.transform = "";
      wrapper.style.width = "";
      wrapper.style.height = "";
      wrapper.style.overflow = "";
    }
  }

  scaleMap();
  window.addEventListener("resize", scaleMap);
};
