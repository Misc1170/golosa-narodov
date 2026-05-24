<div class="flex gap-x-5">
    <div class="w-[157px] h-[157px] shrink-0">
        [[+image:striptags:strip:len:gt=`0`:then=`
            <img src="[[+image]]" alt="[[+name]]" class="w-full h-full rounded-2xl object-cover">
        `:else=`
            <div class="w-full h-full rounded-2xl bg-gray-200 flex items-center justify-center">
                <span class="text-gray-400 text-xs">фото отсутствует</span>
            </div>
        `]]
    </div>
    <div class="flex flex-col justify-start items-start text-xl font-semibold w-full">
        <div class="py-2 pl-4 rounded-3xl border-1 border-[#FFB35B] flex items-center w-full">
            <h2 class="uppercase text-[#EFEADE]">[[+name]]</h2>
        </div>
        <span class="text-white ml-4">[[+position]]</span>
    </div>
</div>