<?php
// Настройки
$out = [];

// Получаем все опубликованные дочерние ресурсы
$criteria = [
    'parent' => 3,
    'published' => 1,
    'deleted' => 0
];
$resources = $modx->getIterator('modResource', $criteria);

foreach ($resources as $res) {
    // Получаем значения TV для каждого ресурса
    $regionIds = $res->getTVValue('region_ident');
    $regionIds = array_map('trim', explode(',', $regionIds));

    foreach ($regionIds as $regionId) {

        // Формируем структуру данных для этого региона
        // Если в одном регионе несколько языков, добавим их в массив
        if (!isset($out[$regionId])) {
            $out[$regionId] = [
                'region_id' => $regionId,
                'languages' => []
            ];
        }

        $parent = $res->getOne('Parent');
        $parentAlias = $parent->get('alias');
        $out[$regionId]['languages'][] = [
            'name' => $res->get('pagetitle'),
            'link' => '/' . $res->get('uri')
        ];
    }
}
// Сбрасываем ключи массива для получения чистого JSON списка [{}, {}]
return json_encode(array_values($out), JSON_UNESCAPED_UNICODE);