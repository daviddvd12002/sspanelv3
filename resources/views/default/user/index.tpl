{include file='user/main.tpl'}

<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
        <h1>
            User Center
            <small>User Center</small>
        </h1>
    </section>

    <!-- Main content -->
    <section class="content">
        <!-- START PROGRESS BARS -->
        <div class="row">
            <div class="col-md-6">
                <div class="box box-primary">
                    <div class="box-header">
                        <i class="fa fa-bullhorn"></i>

                        <h3 class="box-title">Announcement&FAQ</h3>
                    </div>
                    <!-- /.box-header -->
                    <div class="box-body">
                        {$msg}
                    </div>
                    <!-- /.box-body -->
                </div>
                <!-- /.box -->
            </div>
            <!-- /.col (right) -->

            <div class="col-md-6">
                <div class="box box-primary">
                    <div class="box-header">
                        <i class="fa fa-exchange"></i>

                        <h3 class="box-title">Traffic Usage</h3>
                    </div>
                    <!-- /.box-header -->
                    <div class="box-body">
                        <div class="row">
                            <div class="col-xs-12">
                                <div class="progress progress-striped">
                                    <div class="progress-bar progress-bar-primary" role="progressbar" aria-valuenow="40"
                                         aria-valuemin="0" aria-valuemax="100"
                                         style="width: {$user->trafficUsagePercent()}%">
                                        <span class="sr-only">Transfer</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <dl class="dl-horizontal">
                            <dt>Total Traffic</dt>
                            <dd>{$user->enableTraffic()}</dd>
                            <dt>Used Traffic</dt>
                            <dd>{$user->usedTraffic()}</dd>
                            <dt>Remaining Traffic</dt>
                            <dd>{$user->unusedTraffic()}</dd>
                            <dt>Last Used Time</dt>
                            <dd>{$user->lastSsTime()}</dd>
                        </dl>
                    </div>
                    <!-- /.box-body -->
                </div>
                <!-- /.box -->
            </div>
            <!-- /.col (left) -->

            <div class="col-md-6">
                <div class="box box-primary">
                    <div class="box-header">
                        <i class="fa fa-pencil"></i>

                        <h3 class="box-title">Check in to get traffic</h3>
                    </div>
                    <!-- /.box-header -->
                    <div class="box-body">
                        <p> Every {$config['checkinTime']} hours can check-in once.</p>

                        <p>Last check-in time:<code>{$user->lastCheckInTime()}</code></p>
                        {if $user->isAbleToCheckin() }
                            <p id="checkin-btn">
                                <button id="checkin" class="btn btn-success  btn-flat">Check-in</button>
                            </p>
                        {else}
                            <p><a class="btn btn-success btn-flat disabled" href="#">Can not check in</a></p>
                        {/if}
                        <p id="checkin-msg"></p>
                    </div>
                    <!-- /.box-body -->
                </div>
                <!-- /.box -->
            </div>
            <!-- /.col (right) -->

            <div class="col-md-6">
                <div class="box box-primary">
                    <div class="box-header">
                        <i class="fa  fa-paper-plane"></i>

                        <h3 class="box-title">Account Information</h3>
                    </div>
                    <!-- /.box-header -->
                    <div class="box-body">
                        <dl class="dl-horizontal">
                            <dt>Account Level:</dt>
			    {if ($user->plan == 'B')}
			          <dd><font size="2" color="green">PRO plan</font>
			    {else}
				  <dd><font size="2" color="red">FREE plan</font></dd>
			    {/if}
                            <dt>Expire Time:</dt>
                            <dd>{date("Y-m-d H:i:s", $user->expire_time)}</dd>
                            <dt>Remaining time:</dt>
                            {if (($user->expire_time - time()) <0)}
				  <dd><font size="2" color="red">PRO plan has expired！</font></dd>
			    {else}
				  <dd>{number_format(($user->expire_time - time())/86400 ,1)}Day(s)</dd>
			    {/if}
			    <dt></dt><dd>&nbsp;</dd>
			    <dt>Upgrade to Pro plan:</br>$9.99/3months</dt>
                            <dd>
			    <form id="stripe" action="/payment/charge.php" method="post">
				<script src="https://checkout.stripe.com/checkout.js" class="stripe-button"
				data-key="pk_test_Ce0Y0HfJkmbBy58RPWxxujhj"
				data-description="3 Months Pro Plan"
				data-amount="999"
				data-locale="auto">
				</script>
				<input type="hidden" name="userport" value="{$user->port}" />
				<input type="hidden" name="amount" value="999" />
			     </form>
			    
			     </dd>
			   
                        </dl>
                    </div>
             
                    <!-- /.box-body -->
                </div>
                <!-- /.box -->
            </div>
            <!-- /.col (right) -->
     
        </div>
        <!-- /.row --><!-- END PROGRESS BARS -->
    </section>
    <!-- /.content -->
</div><!-- /.content-wrapper -->

<script>
    $(document).ready(function () {
        $("#checkin").click(function () {
            $.ajax({
                type: "POST",
                url: "/user/checkin",
                dataType: "json",
                success: function (data) {
                    $("#checkin-msg").html(data.msg);
                    $("#checkin-btn").hide();
                },
                error: function (jqXHR) {
                    alert("ERROR：" + jqXHR.status);
                }
            })
        })
    })
</script>


{include file='user/footer.tpl'}
