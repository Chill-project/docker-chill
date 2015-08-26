<?php

use Symfony\Component\HttpKernel\Kernel;
use Symfony\Component\Config\Loader\LoaderInterface;

class AppKernel extends Kernel
{
    public function registerBundles()
    {
        $bundles = array(
            new Symfony\Bundle\FrameworkBundle\FrameworkBundle(),
            new Symfony\Bundle\SecurityBundle\SecurityBundle(),
            new Symfony\Bundle\TwigBundle\TwigBundle(),
            new Symfony\Bundle\MonologBundle\MonologBundle(),
            new Symfony\Bundle\AsseticBundle\AsseticBundle(),
            new Sensio\Bundle\FrameworkExtraBundle\SensioFrameworkExtraBundle(),
            new Chill\MainBundle\ChillMainBundle(),
            new Chill\CustomFieldsBundle\ChillCustomFieldsBundle(),
            new Doctrine\Bundle\DoctrineBundle\DoctrineBundle(),
            new Chill\PersonBundle\ChillPersonBundle(),
            new Chill\ReportBundle\ChillReportBundle(),
            new Doctrine\Bundle\MigrationsBundle\DoctrineMigrationsBundle(),
	    new Chill\ActivityBundle\ChillActivityBundle(),
	    new Sensio\Bundle\DistributionBundle\SensioDistributionBundle(),
	    new Doctrine\Bundle\FixturesBundle\DoctrineFixturesBundle()
        );

        return $bundles;
    }

    public function registerContainerConfiguration(LoaderInterface $loader)
    {
        $loader->load(__DIR__.'/config/config_'.$this->getEnvironment().'.yml');
    }
}
