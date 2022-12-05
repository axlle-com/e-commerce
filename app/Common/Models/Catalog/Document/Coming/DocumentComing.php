<?php

namespace App\Common\Models\Catalog\Document\Coming;

use App\Common\Models\Catalog\Document\Main\DocumentBase;
use App\Common\Models\Catalog\FinTransactionType;

/**
 * This is the model class for table "{{%ax_document_coming}}".
 *
 * @property DocumentComingContent[] $contents
 */
class DocumentComing extends DocumentBase
{
    protected $table = 'ax_document_coming';

    public function setCounterpartyId($counterparty_id = null): static
    {
        $this->counterparty_id = $counterparty_id ?? 1;
        return $this;
    }

    protected function setDefaultValue(): void
    {
        parent::setDefaultValue();
        if (empty($this->counterparty_id)) {
            $this->counterparty_id = 1;
        }
    }

    public function setFinTransactionTypeId(): static
    {
        $this->fin_transaction_type_id = FinTransactionType::credit()->id ?? null;
        return $this;
    }
}