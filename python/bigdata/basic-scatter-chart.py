import time
import db
import pyecharts.options as opts
from pyecharts.charts import Scatter

dbconfig = {"host": "10.158.61.166", "port": 3306,
            "user": "big", "password": "afis2020", "database": "bigdata"}

mysql_pool = db.MySQLPool(**dbconfig)

sqlstr = "select message_timestamp, latency from t_login_latency where openday = %s"

data = ("20200506", )

result = mysql_pool.execute(sqlstr, data)

# print("result: {}".format(result))

render_data = [[val['message_timestamp'], val['latency']] for val in result]
# print("result: {}".format(render_data))


render_data.sort(key=lambda x: x[0])

# print("result: {}".format(render_data))

x_data = [time.strftime("%Y-%m-%d %H:%M", time.strptime(d[0],
                                                        '%Y-%m-%d %H:%M:%S.%f')) for d in render_data]

# print("x_data: {}".format(x_data))
y_data = [d[1] for d in render_data]

(
    Scatter(init_opts=opts.InitOpts(width="1200px", height="700px"))
    .add_xaxis(xaxis_data=x_data)
    .add_yaxis(
        series_name="",
        y_axis=y_data,
        symbol_size=4,
        label_opts=opts.LabelOpts(is_show=False),
    )
    .set_series_opts()
    .set_global_opts(
        xaxis_opts=opts.AxisOpts(
            type_="time", splitline_opts=opts.SplitLineOpts(is_show=True),
            max_interval=3600 * 24 * 1000,
        ),
        yaxis_opts=opts.AxisOpts(
            type_="value",
            axistick_opts=opts.AxisTickOpts(is_show=True),
            splitline_opts=opts.SplitLineOpts(is_show=True),
        ),
        tooltip_opts=opts.TooltipOpts(is_show=False),
        title_opts=opts.TitleOpts(title="登录延迟"),
        visualmap_opts=opts.VisualMapOpts(type_="color", max_=800, min_=10),
    )
    .render("basic_scatter_chart.html")
)
