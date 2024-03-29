<?php

namespace App\Common\Jobs;

use App\Common\Models\Catalog\Document\ReservationCancel\DocumentReservationCancel;
use App\Common\Models\Errors\_Errors;
use Exception;
use Illuminate\Contracts\Queue\ShouldBeUnique;

class ReservationCheckJob extends BaseJob implements ShouldBeUnique
{
    public function handle(): void
    {
        try {
            DocumentReservationCancel::reservationCheck();
        } catch(Exception $exception) {
            $this->setErrors(_Errors::exception($exception, $this));
        }
        parent::handle();
    }
}
