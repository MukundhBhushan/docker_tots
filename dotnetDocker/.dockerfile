#first stage

FROM microsoft/dotnet:1.1.1-sdk

RUN mkdir /app
WORKDIR /app

COPY dotnetapp.csproj .
RUN dotnet restore

COPY . .
RUN dotnet publish -c Release -o out

EXPOSE <port to relase>/tcp
CMD ["dotnet", "out/<appldllflie name>.dll"]




# Second Stage
FROM microsoft/dotnet:1.1.1-runtime
WORKDIR /app
CMD ["dotnet", "dotnetapp.dll"]

COPY --from=0 /build/out /app/