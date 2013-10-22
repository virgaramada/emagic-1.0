{include file="header.tpl"}

<table border="0" cellspacing="0" cellpadding="0" id="main-table">
{include file="error_message.tpl"}
  <tr>
   
    <td>
	 <form name="inventory_output_form" id="inventory_output_form" method="post" action="InventoryOutputAction.php{php} echo ("?".strip_tags(SID));{/php}">
      <table border="0" cellspacing="0" cellpadding="1" id="outer-table">
        <tr>
          <td>
          
            <table border="0" cellspacing="0" cellpadding="0" id="inner-table">

            <tr><td colspan="3" id="vertical-spacer"><img src="images/dot.gif" border="0"/></td>
              </tr>
              <tr>
                <td colspan="3" class="title"><img src="images/dot.gif" border="0" height="1" width="10"/>
                {if !empty($inventoryOutput)}
                Ubah
                {else}
                Tambah
                {/if}  {if $smarty.request.productType == 'LUB'} Penyaluran Pelumas {else} Stand meter BBM {/if}</td>
              </tr>
              <tr><td colspan="3" id="vertical-spacer"><img src="images/dot.gif" border="0"/></td>
              </tr>
             
              {if !empty($inventoryOutput)}
              <input type="hidden" name="method" value="update"/>
              <input type="hidden" name="inv_id" value="{$inventoryOutput->getInvId()}"/>
               {else}
               <input type="hidden" name="method" value="create"/>
               {/if}
               <input type="hidden" name="productType" value="{$smarty.request.productType}"/>
                <tr>
                  <td colspan="2"><img src="images/dot.gif" border="0" height="1" width="10"/>Jenis</td>
                  <td><select name="inventory_type" onchange="selectOwnUse();getUnitPrice();">
                  {if !empty($inv_types)}
                     {section name=c loop=$inv_types}
                     {if !empty($inventoryOutput)}
                     <option value="{$inv_types[c]->getInvType()}" {if $inventoryOutput->getInvType() == $inv_types[c]->getInvType()}selected=selected {/if}>{$inv_types[c]->getInvDesc()}</option>
                     {else}
                     <option value="{$inv_types[c]->getInvType()}" {if $smarty.post.inventory_type == $inv_types[c]->getInvType()}selected=selected {/if}>{$inv_types[c]->getInvDesc()}</option>
                     {/if}
                     {/section}
                  {/if}
               </select></td>
               </tr>
                <tr>
                  <td colspan="2"><img src="images/dot.gif" border="0" height="1" width="10"/>Jenis Kendaraan</td>
                  <td> {if !empty($inventoryOutput)}
                     <input type="radio" name="vehicle_type" value="MBL" {if $inventoryOutput->getVehicleType() == 'MBL'}checked=checked {/if}/>Mobil
                     <input type="radio" name="vehicle_type" value="MTR" {if $inventoryOutput->getVehicleType() == 'MTR'}checked=checked {/if}/> Motor
                  {else}
                     <input type="radio" name="vehicle_type" value="MBL" {if $smarty.post.vehicle_type == 'MBL'}checked=checked {/if}/>Mobil
                     <input type="radio" name="vehicle_type" value="MTR" {if $smarty.post.vehicle_type == 'MTR'}checked=checked {/if}/>Motor
                  {/if}
               </td>
               </tr>
               {if $smarty.request.productType == 'LUB'}
               <tr>
                  <td colspan="2"><img src="images/dot.gif" border="0" height="1" width="10"/>Jumlah Penyaluran </td>
                  <td>
                    {if !empty($inventoryOutput)}
                  <input type="text" name="output_value" value="{$inventoryOutput->getOutputValue()}"/>
                  {else}
                    <input type="text" name="output_value" value="{$smarty.post.output_value}"/>
                  {/if}Unit</td>
                </tr>
                {else}
                <input type="hidden" name="output_value" value="0.00"/>
                 <tr>
                  <td colspan="2"><img src="images/dot.gif" border="0" height="1" width="10"/>Stand meter awal </td>
                  <td>
                    {if !empty($inventoryOutput)}
                  <input type="text" name="begin_stand_meter" id="begin_stand_meter" value="{$inventoryOutput->getBeginStandMeter()}"/>
                  {elseif !empty($lastEndStandMeter)}
                  <input type="text" name="begin_stand_meter" id="begin_stand_meter" value="${lastEndStandMeter}" disabled="disabled"/>
                  {else}
                    <input type="text" name="begin_stand_meter" id="begin_stand_meter" value="{$smarty.post.begin_stand_meter}"/>
                  {/if}</td>
                </tr>
                <tr>
                  <td colspan="2"><img src="images/dot.gif" border="0" height="1" width="10"/>Stand meter akhir </td>
                  <td>
                    {if !empty($inventoryOutput)}
                  <input type="text" name="end_stand_meter" value="{$inventoryOutput->getEndStandMeter()}"/>
                  {else}
                    <input type="text" name="end_stand_meter" value="{$smarty.post.end_stand_meter}"/>
                  {/if}</td>
                </tr>
                <tr>
                  <td colspan="2"><img src="images/dot.gif" border="0" height="1" width="10"/>TERA</td>
                  <td>
                    {if !empty($inventoryOutput)}
                  <input type="text" name="tera_value" id="tera_value" value="{$inventoryOutput->getTeraValue()}" onchange="recalculateStandMeter();"/>
                  {else}
                    <input type="text" name="tera_value" id="tera_value" value="{$smarty.post.tera_value}" onchange="recalculateStandMeter();"/>
                  {/if}Liter</td>
                </tr>
                
                 <tr>
                <td colspan="3" id="vertical-spacer"><img src="images/dot.gif" border="0"/></td>
                </tr>
                 <tr>
                  <td colspan="2"><img src="images/dot.gif" border="0" height="1" width="10"/>Shift</td>
                  <td>
                 <select name="output_time_shift"  id="output_time_shift">
                   {if !empty($inventoryOutput)}
                     <option value="1" {if $inventoryOutput->getOutputTimeShift() eq '1'}selected=selected {/if}>I</option>
                     <option value="2" {if $inventoryOutput->getOutputTimeShift() eq '2'}selected=selected {/if}>II</option>
                     <option value="3" {if $inventoryOutput->getOutputTimeShift() eq '3'}selected=selected {/if}>III</option>
                     <option value="4" {if $inventoryOutput->getOutputTimeShift() eq '4'}selected=selected {/if}>IV</option>
                     {else}
                      <option value="1" {if $smarty.post.output_time_shift eq '1'}selected=selected {/if}>I</option>
                     <option value="2" {if $smarty.post.output_time_shift eq '2'}selected=selected {/if}>II</option>
                     <option value="3" {if $smarty.post.output_time_shift eq '3'}selected=selected {/if}>III</option>
                     <option value="4" {if $smarty.post.output_time_shift eq '4'}selected=selected {/if}>IV</option>
                     {/if}
               </select></td>
               </tr>
               <tr>
                <td colspan="3" id="vertical-spacer"><img src="images/dot.gif" border="0"/></td>
              </tr>
             
                <tr>
                  <td colspan="2"><img src="images/dot.gif" border="0" height="1" width="10"/>No. Dispenser</td>
                  <td>
                    {if !empty($inventoryOutput)}
                  <input type="text" name="pump_id" value="{$inventoryOutput->getPumpId()}" onchange="this.value=this.value.toUpperCase();"/>
                  {else}
                    <input type="text" name="pump_id" value="{$smarty.post.pump_id}" onchange="this.value=this.value.toUpperCase();"/>
                  {/if}</td>
                </tr>
                <tr>
                  <td colspan="2"><img src="images/dot.gif" border="0" height="1" width="10"/>No. Nozzle</td>
                  <td>
                    {if !empty($inventoryOutput)}
                  <input type="text" name="nozzle_id" value="{$inventoryOutput->getNozzleId()}"/>
                  {else}
                    <input type="text" name="nozzle_id" value="{$smarty.post.nozzle_id}"/>
                  {/if}</td>
                </tr>
                {/if}
                {*
                <tr>
                  <td colspan="2"><img src="images/dot.gif" border="0" height="1" width="10"/>Tanggal Penyaluran</td>
                  <td>{html_select_date start_year='-2' end_year='+2' field_order=DMY}
                  {if $smarty.request.productType == 'BBM'}
                  jam {html_select_time use_24_hours=true display_seconds=false display_meridian=false}
                  {/if}</td>
                </tr>
                *}
                <tr>
                  <td colspan="2" id="horizontal-spacer"><img src="images/dot.gif" border="0"/>Harga per unit</td>
                  <td id="unit-price"></td>
                </tr>
                <input type="hidden" name="unit_price" value="" id="unit-price-value"/>
                <tr>
                  <td colspan="2"><img src="images/dot.gif" border="0" height="1" width="10"/>Tipe penyaluran</td>
                  <td>
                    <select name="customer_type" onchange="selectOwnUse();getUnitPrice();">
                   {if !empty($cust_types)}
                     {section name=c loop=$cust_types}
                     {if !empty($inventoryOutput)}
                     <option value="{$cust_types[c]->getCustomerType()}" {if $inventoryOutput->getCustomerType() == $cust_types[c]->getCustomerType()}selected=selected {/if}>{$cust_types[c]->getCustomerDesc()}</option>
                     {else}
                     <option value="{$cust_types[c]->getCustomerType()}" {if $smarty.post.customer_type == $cust_types[c]->getCustomerType()}selected=selected {/if}>{$cust_types[c]->getCustomerDesc()}</option>
                     {/if}
                     {/section}
                  {/if}
                    </select></td>
                </tr>
                <tr>
                  <td colspan="2"><img src="images/dot.gif" border="0" height="1" width="10"/>Kategori</td>
                  <td id="own-use"></td>
                 </tr>
                 <input type="hidden" name="category" value="" id="own-use-value"/>
                <tr>
                  <td colspan="3" align="right">
                    <input type="submit" name="submit" value="Proses" id="submit"/><img src="images/dot.gif" border="0" height="1" width="10"/></td>
                </tr>
                <tr>
                <td colspan="3" id="vertical-spacer"><img src="images/dot.gif" border="0"/></td>
                </tr>
             
            </table>
             
          </td>
        </tr>
      </table>
	  </form>
      {if $smarty.request.productType == 'LUB'} {include file="inventory_output_list.tpl"} {else} {include file="stand_meter_list.tpl"}{/if}
    </td>
  </tr>
</table>
<script type="text/javascript" src="./js/stand_meter.js"></script>
{include file="footer.tpl"}
