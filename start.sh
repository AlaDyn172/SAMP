sleep 3

CHK_FILE="/home/container/samp03svr"
if [ -f $CHK_FILE ]; then
    echo "Executable of SAMP exists, not downloading. To update, delete samp03svr."
else
    mkdir -p /home/container/.tmp-build
    cd /home/container/.tmp-build

    echo "> curl -sSLO http://files.sa-mp.com/samp037svr_R2-1.tar.gz"
    curl -sSLO http://files.sa-mp.com/samp037svr_R2-1.tar.gz

    echo "> tar -xjvf samp037svr_R2-1.tar.gz"
    tar -zxf samp037svr_R2-1.tar.gz

    cp -r samp03/* /home/container/
    rm -r /home/container/.tmp-build
    cd /home/container
    chmod 700 *
fi

if [ -f "/home/container/server.cfg" ]; then
    echo "Server.cfg file exists, not creating another."
else
    echo "lanmode 0
rcon_password ChangePasword!@#!@#
maxplayers 50
port ${SERVER_PORT}
hostname SA-MP 0.3 Server
gamemode0 grandlarc 1
filterscripts base gl_actions gl_property gl_realtime
announce 0
query 1
weburl www.sa-mp.com
maxnpc 0
onfoot_rate 40
incar_rate 40
weapon_rate 40
stream_distance 300.0
stream_rate 1000" > server.cfg
fi

cd /home/container
MODIFIED_STARTUP=`eval echo $(echo ${STARTUP} | sed -e 's/{{/${/g' -e 's/}}/}/g')`
./samp03svr
