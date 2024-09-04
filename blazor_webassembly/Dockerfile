FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build

WORKDIR /src
COPY qotd-frontend-blazor.csproj .
COPY /wwwroot/appsettings.json .
RUN dotnet restore qotd-frontend-blazor.csproj


COPY . .
RUN dotnet build qotd-frontend-blazor.csproj -c Release -o /app/build

FROM build AS publish
RUN dotnet publish qotd-frontend-blazor.csproj -c Release -o /app/publish

FROM docker.io/nginx AS final
WORKDIR /usr/share/nginx/html
COPY --from=build /src/appsettings.json .


COPY --from=build /src/container_run.sh .
COPY --from=publish /app/publish/wwwroot .
COPY nginx.conf /etc/nginx/nginx.conf
RUN chown -R 1001:0 /var/cache/nginx && chmod -R ug+rwx /var/cache/nginx && chown -R 1001:0 /var/run

RUN chmod +x ./container_run.sh
RUN chmod 777 ./

USER 1001
EXPOSE 5050

CMD ./container_run.sh