{{- $_domains := list "localhost" }}
{{- if .Values.nextcloud.trustedDomains }}
{{- $_domains = concat $_domains .Values.nextcloud.trustedDomains }}
{{- else }}
{{- $_domains = append $_domains .Values.nextcloud.host }}
{{- if .Values.metrics.enabled }}
{{- $_domains = append $_domains (printf "%s.%s.%s" (include "nextcloud.fullname" .) .Release.Namespace "svc.cluster.local") }}
{{- end }}
{{- end -}}
<?php
$CONFIG = array (
  'trusted_domains' => array(
  {{- range $i, $domain := $_domains }}
    {{ $i }} => '{{ $domain }}',
  {{- end }}
    {{ len $_domains }} => getenv('POD_IP'),
  ),
);