{include file="header.tpl"}

<table  border="0" cellspacing="0" cellpadding="0" id="main-table">
{include file="error_message.tpl"}
  <tr>
    
    <td>
	<form name="real_stock_form" method="post" action="RealStockAction.php{php} echo ("?".strip_tags(SID));{/php}">
      <table  border="0" cellspacing="0" cellpadding="1" id="outer-table">
        <tr>
          <td>
			<div class="tabulation">
			<span class="active-tabForm ">
			{if !empty($realStock)} Ubah {else} Tambah{/if} Real Stock
			</span>
			</div>
			<div class="tabbodycolored">
            <table  border="0" cellspacing="0" cellpadding="0" id="inner-table">
              
              {if !empty($realStock)}
              <input type="hidden" name="method" value="update"/>
              <input type="hidden" name="real_stock_id" value="{$realStock->getRealStockId()}"/>
               {else}
               <input type="hidden" name="method" value="create"/>
               {/if}
                <tr>
                  <td colspan="2"><img src="images/dot.gif" border="0" height="1" width="10"/>Jenis Bahan Bakar</td>
                  <td><select name="inventory_type">
                  {if !empty($inv_types)}
                     {section name=c loop=$inv_types}
                     {if !empty($realStock)}
                     <option value="{$inv_types[c]->getInvType()}" {if $realStock->getInvType() == $inv_types[c]->getInvType()}selected=selected {/if}>{$inv_types[c]->getInvDesc()}</option>
                     {else}
                     <option value="{$inv_types[c]->getInvType()}" {if $smarty.post.inventory_type == $inv_types[c]->getInvType()}selected=selected {/if}>{$inv_types[c]->getInvDesc()}</option>
                     {/if}
                     {/section}
                  {/if}
               </select></td>
               </tr>
                <tr><td colspan="3" id="vertical-spacer"><img src="images/dot.gif" border="0"/></td>
              </tr>
                <tr>
                <td colspan="2"><img src="images/dot.gif" border="0" height="1" width="10"/>Kuantitas</td>
                <td> {if !empty($realStock)}
                  <input type="text" name="quantity" value="{$realStock->getQuantity()}"/>
                  {else}
                    <input type="text" name="quantity" value="{$smarty.post.quantity}"/>
                  {/if} Liter</td>
                </tr>
                 <tr><td colspan="3" id="vertical-spacer"><img src="images/dot.gif" border="0"/></td>
              </tr>
                <tr>
                <td colspan="2"><img src="images/dot.gif" border="0" height="1" width="10"/>Tanggal Berlaku</td>
                <td>
                 {html_select_date end_year='+1' field_order=DMY prefix='Start_Date_'} s.d. {html_select_date end_year='+1' field_order=DMY prefix='End_Date_'}
                  </td>
                </tr>
                {if !empty($realStock)}
                	<script type="text/javascript">
		             recalculateDate('Start_Date_', document.real_stock_form, '{$realStock->getStartDate()}');
		             recalculateDate('End_Date_', document.real_stock_form, '{$realStock->getEndDate()}');
		          </script>
		        {/if}
                <tr>
                  <td colspan="3" align="right">
                    <input type="submit" name="submit" value="Proses" id="submit"/><img src="images/dot.gif" border="0" height="1" width="10"/>
                  </td>
                </tr>
                <tr>
                <td colspan="3" id="vertical-spacer"><img src="images/dot.gif" border="0"/></td>
                </tr>
             
            </table>
            </div>
			<div class="tabbtmcolored"></div>
          </td>
        </tr>
         
      </table>
	    </form>
      {include file="real_stock_list.tpl"}
    </td>
  </tr>
</table>
{include file="footer.tpl"}