{include file='user/main.tpl'}

<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
        <h1>
            Subscription
            <small>Subscription</small>
        </h1>
    </section>

    <!-- Main content --><!-- Main content -->
    <section class="content">
        <div class="row">
            <div class="col-sm-12">
                <div id="msg-error" class="alert alert-warning alert-dismissable" style="display:none">
                    <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                    <h4><i class="icon fa fa-warning"></i> ERROR!</h4>

                    <p id="msg-error-p"></p>
                </div>
            </div>
        </div>
        <div class="row">
            <!-- left column -->
            <div class="col-md-6">
                <!-- general form elements -->
                <div class="box box-primary">
                    <div class="box-header">
                        <i class="fa fa-rocket"></i>

                        <h3 class="box-title">Subscription</h3>
                    </div>
                    <!-- /.box-header -->
                    <div class="box-body">
                        <p>Coming soon！ </p>

                    </div>
                    <!-- /.box -->
                    <div class="box-header">
                        <h3 class="box-title">Payment</h3>
                    </div>
                    <!-- /.box-header -->

                </div>
            </div>


        </div>
    </section>
    <!-- /.content -->
</div><!-- /.content-wrapper -->

<script>
    $(document).ready(function () {
        $("#invite").click(function () {
            $.ajax({
                type: "POST",
                url: "/user/invite",
                dataType: "json",
                data: {
                    num: $("#num").val()
                },
                success: function (data) {
                    window.location.reload();
                },
                error: function (jqXHR) {
                    alert("ERROR：" + jqXHR.status);
                }
            })
        })
    })
</script>

{include file='user/footer.tpl'}
