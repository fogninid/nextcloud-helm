{{- $_domains := list "localhost" }}
{{- $_domains = concat $_domains ( (include "nextcloud.trustedDomainsJson" . ) | fromJsonArray ) -}}
<?php
$CONFIG = array (
  'trusted_domains' => array(
  {{- range $i, $domain := $_domains }}
    {{ $i }} => '{{ $domain }}',
  {{- end }}
    {{ len $_domains }} => getenv('POD_IP'),
  ),
);