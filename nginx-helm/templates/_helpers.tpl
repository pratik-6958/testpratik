{{- define "nginx-helm.name" -}}
{{- default .Chart.Name .Values.nameOverride -}}
{{- end -}}

{{- define "nginx-helm.fullname" -}}
{{- printf "%s-%s" (include "nginx-helm.name" .) .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
