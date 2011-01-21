<?php

class Bootstrap extends Zend_Application_Bootstrap_Bootstrap
{

#    protected function _initAcl()
#    {
#        require_once 'configs/configAcl.php';
#
#        require_once 'plugins/AclPlugin.php';
#
#        $front = Zend_Controller_Front::getInstance();
#        $front->registerPlugin(new AclPlugin());
#    }

    protected function _initNavigation()
    {
        $this->bootstrap('layout');
        $layout = $this->getResource('layout');
        $view = $layout->getView();
        $navigation = new Zend_Navigation($this->getOption('navigation'));
        $view->navigation($navigation);
    }
}
