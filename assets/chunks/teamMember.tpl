<div class="flex flex-col justify-center items-center xl:items-start xl:flex-row gap-y-3 xl:gap-x-5">
    <div class="w-[172px] h-[172px] xl:w-[157px] xl:h-[157px] shrink-0">
        [[+image:striptags:strip:len:gt=`0`:then=`
            <img src="[[+image]]" alt="[[+name]]" class="w-full h-full rounded-2xl object-cover">
        `:else=`
            <div class="w-full h-full rounded-2xl bg-gray-200 flex items-center justify-center">
                <span class="text-gray-400 text-xs">фото отсутствует</span>
            </div>
        `]]
    </div>
    <div class="flex flex-col justify-center items-center xl:justify-start xl:items-start xl:text-xl font-semibold w-full">
        <div class="py-2 xl:pl-4 rounded-3xl border-2 border-[#FFB35B] flex items-center justify-center xl:justify-start w-full">
            <h2 class="uppercase text-[#EFEADE] text-[15px] xl:text-xl font-semibold">[[+name]]</h2>
        </div>
        <span class="text-white text-[15px] xl:text-xl font-semibold xl:ml-4 text-center">[[+position]]</span>
    </div>
    </div>