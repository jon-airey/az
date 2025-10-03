TO INSTALL
    ./validate.sh       ->  Can see detailed error before install
    ./install.sh        ->  Will issue `az deployment sub create` and use main.bicept file
    ./build.sh          ->  Build target Dockerfile to acn repo
    ./run.sh            ->  Run container from acn using kubectl

TO CLEAN UP
    ./uninstall.sh      -> deprovision created azure resources
    ./clean.sh          -> clean/remove queued deployments (optional)

INSPECTION
    ./overview.sh       -> overview and azure state
