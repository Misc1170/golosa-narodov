<?php
/* Smarty version 4.5.6, created on 2026-05-02 22:29:27
  from 'C:\OSPanel2\domains\golosa_modx\manager\templates\default\dashboard\updates.tpl' */

/* @var Smarty_Internal_Template $_smarty_tpl */
if ($_smarty_tpl->_decodeProperties($_smarty_tpl, array (
  'version' => '4.5.6',
  'unifunc' => 'content_69f65097795247_68001685',
  'has_nocache_code' => false,
  'file_dependency' => 
  array (
    '3591224b93ff78591b0108cab8fab7a78e4a0dc8' => 
    array (
      0 => 'C:\\OSPanel2\\domains\\golosa_modx\\manager\\templates\\default\\dashboard\\updates.tpl',
      1 => 1771302406,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
  ),
),false)) {
function content_69f65097795247_68001685 (Smarty_Internal_Template $_smarty_tpl) {
?><div id="modx-grid-updates" class="updates-widget">
    <div class="table-wrapper">
        <table class="table">
            <thead>
            <tr>
                <th><?php echo $_smarty_tpl->tpl_vars['_lang']->value['updates_type'];?>
</th>
                <th><?php echo $_smarty_tpl->tpl_vars['_lang']->value['updates_status'];?>
</th>
                <th><?php echo $_smarty_tpl->tpl_vars['_lang']->value['updates_action'];?>
</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td><span class="updates-title">MODX</span></td>
                <?php if ($_smarty_tpl->tpl_vars['modx']->value['updateable']) {?>
                    <td><span class="updates-available"><?php echo $_smarty_tpl->tpl_vars['modx']->value['latest']['version'];?>
</span></td>
                    <td>
                        <a 
                            href="javascript:;"
                            data-download-id="<?php echo $_smarty_tpl->tpl_vars['modx']->value['latest']['downloadId'];?>
"
                            class="dashboard-button modx"
                            target="_blank"
                        >
                            <?php echo $_smarty_tpl->tpl_vars['_lang']->value['download'];?>

                        </a>
                    </td>
                <?php } else { ?>
                    <td><span class="updates-ok"><?php echo $_smarty_tpl->tpl_vars['_lang']->value['updates_ok'];?>
</span></td>
                    <td><button class="dashboard-button modx" disabled><?php echo $_smarty_tpl->tpl_vars['_lang']->value['download'];?>
</button></td>
                <?php }?>
            </tr>
            <tr>
                <?php if ($_smarty_tpl->tpl_vars['extras']->value['updateable']) {?>
                    <td>
                        <span class="updates-title"><?php echo $_smarty_tpl->tpl_vars['_lang']->value['updates_extras'];?>
</span>
                        <span class="updates-updateable">
                            <?php if ($_smarty_tpl->tpl_vars['extras']->value['updateable'] > 10) {?>10+<?php } else {
echo $_smarty_tpl->tpl_vars['extras']->value['updateable'];
}?>
                        </span>
                    </td>
                    <td><span class="updates-available"><?php echo $_smarty_tpl->tpl_vars['_lang']->value['updates_available'];?>
</span></td>
                    <td>
                        <a href="<?php echo $_smarty_tpl->tpl_vars['_config']->value['manager_url'];?>
?a=workspaces"
                           class="dashboard-button package"><?php echo $_smarty_tpl->tpl_vars['_lang']->value['updates_update'];?>
</a>
                    </td>
                <?php } else { ?>
                    <td><span class="updates-title"><?php echo $_smarty_tpl->tpl_vars['_lang']->value['updates_extras'];?>
</span></td>
                    <td><span class="updates-ok"><?php echo $_smarty_tpl->tpl_vars['_lang']->value['updates_ok'];?>
</span></td>
                    <td><button class="dashboard-button package" disabled><?php echo $_smarty_tpl->tpl_vars['_lang']->value['updates_update'];?>
</button></td>
                <?php }?>
            </tr>
            </tbody>
        </table>
    </div>
</div>


    <?php echo '<script'; ?>
>
        const
            updatesGrid = document.getElementById('modx-grid-updates'),
            modxLinks = document.querySelectorAll('.dashboard-button.modx')
        ;
        modxLinks.forEach(link => {
            link.addEventListener('click', e => {
                e.preventDefault();
                const updatesMask = new Ext.LoadMask(updatesGrid, {
                    msg: _('downloading')
                });
                updatesMask.show();
                MODx.Ajax.request({
                    url: MODx.config.connector_url,
                    params: {
                        action: 'SoftwareUpdate/GetFile',
                        downloadId: link.dataset.downloadId
                    },
                    scope: this,
                    listeners: {
                        success: {
                            fn: function(response) {
                                const url = response.object?.zip;
                                if (!Ext.isEmpty(url)) {
                                    window.location.assign(url);
                                    setTimeout(() => {
                                        updatesMask.hide();
                                    }, 1000);
                                }
                            },
                            scope:this
                        },
                        failure: {
                            fn: function(response) {
                                updatesMask.hide();
                            },
                            scope:this
                        }
                    }
                });
            });
        });
    <?php echo '</script'; ?>
>
    <?php }
}
