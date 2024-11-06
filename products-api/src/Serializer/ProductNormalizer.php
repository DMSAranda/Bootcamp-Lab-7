<?php

// src/Serializer/ProductNormalizer.php

namespace App\Serializer;

use Symfony\Component\Serializer\Normalizer\ObjectNormalizer;
use Symfony\Component\Serializer\Normalizer\NormalizerInterface;

class ProductNormalizer extends ObjectNormalizer implements NormalizerInterface
{
    public function normalize($object, $format = null, array $context = [])
    {
        // Añade lógica para normalizar la entidad Product según tus necesidades
        return parent::normalize($object, $format, $context);
    }
}
