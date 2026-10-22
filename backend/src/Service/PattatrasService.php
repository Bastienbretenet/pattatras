<?php

declare(strict_types=1);

namespace App\Service;

final class PattatrasService
{
    public const int MIN = 1;
    public const int MAX = 6457;

    private const array LABELS = [
        'pattatras' => 'Pattatras',
        'patte' => 'Patte',
        'tatras' => 'Tatras',
    ];

    /**
     * Le cas "multiple de 3 et de 5" est testé en premier : concaténer
     * "Patte" + "Tatras" donnerait "PatteTatras", pas "Pattatras".
     *
     * @return 'pattatras'|'patte'|'tatras'|'nombre'
     */
    public function type(int $number): string
    {
        return match (true) {
            0 === $number % 15 => 'pattatras',
            0 === $number % 3 => 'patte',
            0 === $number % 5 => 'tatras',
            default => 'nombre',
        };
    }

    public function convert(int $number): string
    {
        return self::LABELS[$this->type($number)] ?? (string) $number;
    }

    /**
     * @return array{number: int, value: string, type: string}
     */
    public function result(int $number): array
    {
        return ['number' => $number, 'value' => $this->convert($number), 'type' => $this->type($number)];
    }

    /**
     * @return list<array{number: int, value: string, type: string}>
     */
    public function generate(int $min = self::MIN, int $max = self::MAX): array
    {
        return array_map($this->result(...), range($min, $max));
    }
}
