<?php
/* Smarty version 4.5.6, created on 2026-05-02 23:46:28
  from 'C:\OSPanel2\domains\golosa_modx\manager\templates\default\element\tv\renders\input\checkbox.tpl' */

/* @var Smarty_Internal_Template $_smarty_tpl */
if ($_smarty_tpl->_decodeProperties($_smarty_tpl, array (
  'version' => '4.5.6',
  'unifunc' => 'content_69f662a4992b88_03383847',
  'has_nocache_code' => false,
  'file_dependency' => 
  array (
    '28933adb944dca172d7a7e6b635473ad872dad96' => 
    array (
      0 => 'C:\\OSPanel2\\domains\\golosa_modx\\manager\\templates\\default\\element\\tv\\renders\\input\\checkbox.tpl',
      1 => 1771302406,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
  ),
),false)) {
function content_69f662a4992b88_03383847 (Smarty_Internal_Template $_smarty_tpl) {
?><div id="tv<?php echo $_smarty_tpl->tpl_vars['tv']->value->id;?>
-cb"></div>

<?php echo '<script'; ?>
>
// <![CDATA[

Ext.onReady(function() {
    const fld = MODx.load({
    
        xtype: 'checkboxgroup',
        id: 'tv<?php echo $_smarty_tpl->tpl_vars['tv']->value->id;?>
',
        itemId: 'tv<?php echo $_smarty_tpl->tpl_vars['tv']->value->id;?>
',
        <?php if ($_smarty_tpl->tpl_vars['params']->value['columnDirection'] == 'vertical' || $_smarty_tpl->tpl_vars['params']->value['columnDirection'] == null) {?>vertical: true,<?php }?>
        columns: <?php if ((($tmp = $_smarty_tpl->tpl_vars['params']->value['columns'] ?? null)===null||$tmp==='' ? '' ?? null : $tmp)) {
echo (($tmp = $_smarty_tpl->tpl_vars['params']->value['columns'] ?? null)===null||$tmp==='' ? '' ?? null : $tmp);
} else { ?>1<?php }?>,
        <?php if ($_smarty_tpl->tpl_vars['params']->value['wrapColumnText'] == 1 || $_smarty_tpl->tpl_vars['params']->value['wrapColumnText'] == 'true') {?>ctCls: 'wrap-columns column-width-<?php if ($_smarty_tpl->tpl_vars['params']->value['columnWidth']) {
echo strtr((string)$_smarty_tpl->tpl_vars['params']->value['columnWidth'], array("\\" => "\\\\", "'" => "\\'", "\"" => "\\\"", "\r" => "\\r", 
                       "\n" => "\\n", "</" => "<\/", "<!--" => "<\!--", "<s" => "<\s", "<S" => "<\S",
                       "`" => "\\`", "\${" => "\\\$\{"));
} else { ?>medium<?php }?>',<?php }?>
        renderTo: 'tv<?php echo $_smarty_tpl->tpl_vars['tv']->value->id;?>
-cb',
        name: 'tv-<?php echo $_smarty_tpl->tpl_vars['tv']->value->id;?>
',
        allowBlank: <?php if ($_smarty_tpl->tpl_vars['params']->value['allowBlank'] == 1 || $_smarty_tpl->tpl_vars['params']->value['allowBlank'] == 'true') {?>true<?php } else { ?>false<?php }?>,
        hideMode: 'offsets',
        msgTarget: 'under',
        items: [<?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['opts']->value, 'item', false, 'k', 'cbs', array (
  'last' => true,
  'iteration' => true,
  'total' => true,
));
$_smarty_tpl->tpl_vars['item']->do_else = true;
if ($_from !== null) foreach ($_from as $_smarty_tpl->tpl_vars['k']->value => $_smarty_tpl->tpl_vars['item']->value) {
$_smarty_tpl->tpl_vars['item']->do_else = false;
$_smarty_tpl->tpl_vars['__smarty_foreach_cbs']->value['iteration']++;
$_smarty_tpl->tpl_vars['__smarty_foreach_cbs']->value['last'] = $_smarty_tpl->tpl_vars['__smarty_foreach_cbs']->value['iteration'] === $_smarty_tpl->tpl_vars['__smarty_foreach_cbs']->value['total'];
?>
        {
            name: 'tv<?php echo $_smarty_tpl->tpl_vars['tv']->value->id;?>
[]',
            id: 'tv<?php echo $_smarty_tpl->tpl_vars['tv']->value->id;?>
-<?php echo $_smarty_tpl->tpl_vars['k']->value;?>
',
            <?php if ($_smarty_tpl->tpl_vars['params']->value['displayAsSwitch'] == 1 || $_smarty_tpl->tpl_vars['params']->value['displayAsSwitch'] == 'true') {?>ctCls: 'display-switch',<?php }?>
            boxLabel: '<?php echo strtr((string)$_smarty_tpl->tpl_vars['item']->value['text'], array("\\" => "\\\\", "'" => "\\'", "\"" => "\\\"", "\r" => "\\r", 
                       "\n" => "\\n", "</" => "<\/", "<!--" => "<\!--", "<s" => "<\s", "<S" => "<\S",
                       "`" => "\\`", "\${" => "\\\$\{"));?>
',
            checked: <?php if ($_smarty_tpl->tpl_vars['item']->value['checked']) {?>true<?php } else { ?>false<?php }?>,
            inputValue: <?php echo $_smarty_tpl->tpl_vars['item']->value['value'];?>
,
            value: <?php echo $_smarty_tpl->tpl_vars['item']->value['value'];?>

        }<?php if (!(isset($_smarty_tpl->tpl_vars['__smarty_foreach_cbs']->value['last']) ? $_smarty_tpl->tpl_vars['__smarty_foreach_cbs']->value['last'] : null)) {?>,<?php }?>
        <?php
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>]
    });
    <?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['opts']->value, 'item', false, 'k', 'cbs', array (
  'last' => true,
  'iteration' => true,
  'total' => true,
));
$_smarty_tpl->tpl_vars['item']->do_else = true;
if ($_from !== null) foreach ($_from as $_smarty_tpl->tpl_vars['k']->value => $_smarty_tpl->tpl_vars['item']->value) {
$_smarty_tpl->tpl_vars['item']->do_else = false;
$_smarty_tpl->tpl_vars['__smarty_foreach_cbs']->value['iteration']++;
$_smarty_tpl->tpl_vars['__smarty_foreach_cbs']->value['last'] = $_smarty_tpl->tpl_vars['__smarty_foreach_cbs']->value['iteration'] === $_smarty_tpl->tpl_vars['__smarty_foreach_cbs']->value['total'];
?>
    Ext.getCmp('tv<?php echo $_smarty_tpl->tpl_vars['tv']->value->id;?>
-<?php echo $_smarty_tpl->tpl_vars['k']->value;?>
').on('check',MODx.fireResourceFormChange);
    <?php
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>

    Ext.get('tvdef<?php echo $_smarty_tpl->tpl_vars['tv']->value->id;?>
').dom.value = "<?php echo $_smarty_tpl->tpl_vars['cbdefaults']->value;?>
";
    Ext.getCmp('modx-panel-resource').getForm().add(fld);
});
// ]]>
<?php echo '</script'; ?>
>
<?php }
}
