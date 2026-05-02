/**
 * Рендер Российской карты.
 *
 * Перед подключением этой библиотеки должна быть подключена библиотека RaphelJS:
 *
 * @see http://dmitrybaranovskiy.github.io/raphael/
 *
 * Состав опций:
 * - mapId - идентификатор элемента, в котором будет срендерена карта
 * - width - ширина карты
 * - height - высота карты
 * - defaultAttr - дефолтовые атрибуты полигона
 * - mouseMoveAttr - атрибуты для полигона при наведении мышки
 * - onMouseMove - событие при наведении мышки на регион
 * - onMouseOut - событие при убирании мышки с региона
 * - onMouseClick - событие при клике
 * - viewPort - смещение координат в SVG
 * - viewSize - видимые границы в SVG
 *
 * @param {Object} options Опции
 * @param {Array} regions Регионы, каждый элемент состоит из:
 *  ident - идентификатора,
 *  name - названия,
 *  attr - необязательное, атрибуты, которые будут перекрывать атрибуты по умолчанию,
 *  moveAttr - необязательное, атрибуты, которые будут перекрывать атрибуты при наведении,
 *  paths - массив атрибутов path
 *  polygons - массив атрибутов polygon
 */

export default function RussianMap(options, regions) {
  var mapId = options.mapId;
  var width = options.width;
  var height = options.height;
  var viewPort = options.viewPort || "0 0 1134 620";
  var viewSize = options.viewSize || "700 700";
  var selectedRegion = null;

  // канва для рисования регионов
  const Raphael = window.Raphael;
  var R = Raphael(mapId, width, height, viewPort, viewSize);

  var defaultAttr = options.defaultAttr;
  var mouseMoveAttr = options.mouseMoveAttr;
  var mouseClickAttr = options.mouseClickAttr;

  /**
   * Событие onMouseMove для path или polygon внутри контекста полигона (можно использовать this).
   */
  var onMouseMove = function (event) {
    var region = this.region;

    // Не менять стиль выбранного региона
    if (selectedRegion === region) {
      return;
    }

    if (region.paths !== undefined) {
      for (var p in region.paths) {
        region.paths[p].attr(mouseMoveAttr);
      }
    }

    if (region.polygons !== undefined) {
      for (var p in region.polygons) {
        region.polygons[p].attr(mouseMoveAttr);
      }
    }

    if (options.onMouseMove) {
      options.onMouseMove.call(this, event);
    }
  };

  /**
   * Событие при клике на полигон
   */
  var onMouseClick = function (event) {
    var region = this.region;

    var resetStyle = function (reg) {
      var baseAttr = reg.attr || defaultAttr;
      return {
        ...baseAttr,
        stroke: defaultAttr.stroke,
        "stroke-width": defaultAttr["stroke-width"],
      };
    };

    if (selectedRegion === region) {
      const label = document.getElementById("region-label");
      if (label) label.style.display = "none";

      var style = resetStyle(region);
      if (region.paths) {
        for (var p in region.paths) region.paths[p].attr(style);
      }
      if (region.polygons) {
        for (var p in region.polygons) region.polygons[p].attr(style);
      }

      selectedRegion = null;
      return;
    }

    // Сброс предыдущего региона
    if (selectedRegion && selectedRegion !== region) {
      var prevStyle = resetStyle(selectedRegion);
      if (selectedRegion.paths) {
        for (var p in selectedRegion.paths)
          selectedRegion.paths[p].attr(prevStyle);
      }
      if (selectedRegion.polygons) {
        for (var p in selectedRegion.polygons)
          selectedRegion.polygons[p].attr(prevStyle);
      }
    }

    // Установить клик (желтая граница)
    if (region.paths) {
      for (var p in region.paths) region.paths[p].attr(mouseClickAttr);
    }
    if (region.polygons) {
      for (var p in region.polygons) region.polygons[p].attr(mouseClickAttr);
    }

    selectedRegion = region;
    if (options.onMouseClick) options.onMouseClick.call(this, event);
  };

  /**
   * Событие onMouseOut для path или polygon внутри контекста полигона (можно использовать this)
   */
  var onMouseOut = function (event) {
    var region = this.region;

    // Если регион выбран — не сбрасывать стиль
    if (selectedRegion === region) {
      return;
    }

    if (region.paths !== undefined) {
      for (var p in region.paths) {
        region.paths[p].attr(region.attr || defaultAttr);
      }
    }

    if (region.polygons !== undefined) {
      for (var p in region.polygons) {
        region.polygons[p].attr(region.attr || defaultAttr);
      }
    }

    if (options.onMouseOut) {
      options.onMouseOut.call(this, event);
    }
  };

  /**
   * Рендер региона
   * @param R
   * @param region
   */
  var renderRegion = function (region) {
    // прорисовка многоугольников
    if (region.paths !== undefined) {
      for (var p in region.paths) {
        var path = R.path(region.paths[p]).attr(region.attr || defaultAttr);
        path.region = region;
        path.mouseover(onMouseMove);
        path.mouseout(onMouseOut);
        path.click(onMouseClick);
        region.paths[p] = path;
      }
    }
    // прорисовка полигнов: также через тег path, только конечная точка соединяется с начальной
    if (region.polygons !== undefined) {
      for (var p in region.polygons) {
        var polygon = R.path("M" + region.polygons[p]).attr(
          region.attr || defaultAttr,
        );
        polygon.region = region;
        polygon.mouseover(onMouseMove);
        polygon.mouseout(onMouseOut);
        polygon.click(onMouseClick);
        region.polygons[p] = polygon;
      }
    }
  };

  const activeRegions = window.activeRegions || [];
  for (var i in regions) {
    const foundData = activeRegions.find(item => item.region_id === regions[i].ident);
    if (foundData) {
      regions[i].attr = mouseMoveAttr;
    } else {
      regions[i].attr = defaultAttr;
    }

    renderRegion(regions[i]);
  }

  this.regions = regions;
}
