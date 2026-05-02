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
        fill: "#EFEADE",
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
      onMouseMove: function (event) {
        console.log(
          "MouseMove on " + this.region.name,
          "ident: " + this.region.ident,
        );
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
};
