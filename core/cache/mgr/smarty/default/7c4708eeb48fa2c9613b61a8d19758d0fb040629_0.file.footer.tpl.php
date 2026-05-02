<?php
/* Smarty version 4.5.6, created on 2026-04-25 15:33:25
  from 'C:\OSPanel2\domains\golosa_modx\manager\templates\default\footer.tpl' */

/* @var Smarty_Internal_Template $_smarty_tpl */
if ($_smarty_tpl->_decodeProperties($_smarty_tpl, array (
  'version' => '4.5.6',
  'unifunc' => 'content_69ecb495c70ca8_69114188',
  'has_nocache_code' => false,
  'file_dependency' => 
  array (
    '7c4708eeb48fa2c9613b61a8d19758d0fb040629' => 
    array (
      0 => 'C:\\OSPanel2\\domains\\golosa_modx\\manager\\templates\\default\\footer.tpl',
      1 => 1771302406,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
  ),
),false)) {
function content_69ecb495c70ca8_69114188 (Smarty_Internal_Template $_smarty_tpl) {
?>    </div>
    <!-- #modx-content-->
    <div id="modx-footer"></div>
</div>
<!-- #modx-container -->

<?php
$_from = $_smarty_tpl->smarty->ext->_foreach->init($_smarty_tpl, $_smarty_tpl->tpl_vars['jsbody']->value, 'scr');
$_smarty_tpl->tpl_vars['scr']->do_else = true;
if ($_from !== null) foreach ($_from as $_smarty_tpl->tpl_vars['scr']->value) {
$_smarty_tpl->tpl_vars['scr']->do_else = false;
?>
    <?php echo $_smarty_tpl->tpl_vars['scr']->value;?>

<?php
}
$_smarty_tpl->smarty->ext->_foreach->restore($_smarty_tpl, 1);?>

</body>
</html>
<?php }
}
