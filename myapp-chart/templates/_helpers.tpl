{{- define "myapp.name" -}}
myapp
{{- end -}}

{{- define "myapp.fullname" -}}
{{ .Release.Name }}-myapp
{{- end -}}
