
program Pathfinder;

{$mode objfpc}{$H+}

uses
  SysUtils;

const
  MAX_NODES = 20;
  MAX_EDGES = 50;
  INF = 1.0E100;

type
  TNode = record
    name: string;
  end;

  TEdge = record
    source, destination: Integer;
    distanceKm: Real;
    timeMinutes: Real;
    costRupiah: Real;
    isOpen: Boolean;
  end;

  TNodeArray = array[1..MAX_NODES] of TNode;
  TEdgeArray = array[1..MAX_EDGES] of TEdge;
  TRealArray = array[1..MAX_NODES] of Real;
  TIntArray = array[1..MAX_NODES] of Integer;
  TBoolArray = array[1..MAX_NODES] of Boolean;

var
  Nodes: TNodeArray;
  Edges: TEdgeArray;
  NodeCount, EdgeCount: Integer;

procedure AddNode(const NodeName: string);
begin
  if NodeCount >= MAX_NODES then
  begin
    Writeln('Kapasitas lokasi penuh.');
    Exit;
  end;

  Inc(NodeCount);
  Nodes[NodeCount].name := NodeName;
end;

procedure AddEdge(A, B: Integer; D, T, C: Real);
begin
  if EdgeCount >= MAX_EDGES then
  begin
    Writeln('Kapasitas jalan penuh.');
    Exit;
  end;

  Inc(EdgeCount);
  Edges[EdgeCount].source := A;
  Edges[EdgeCount].destination := B;
  Edges[EdgeCount].distanceKm := D;
  Edges[EdgeCount].timeMinutes := T;
  Edges[EdgeCount].costRupiah := C;
  Edges[EdgeCount].isOpen := True;
end;

procedure InitializeData;
begin
  NodeCount := 0;
  EdgeCount := 0;

  AddNode('Kampus');
  AddNode('Perpustakaan');
  AddNode('Rumah Sakit');
  AddNode('Pusat Kota');
  AddNode('Terminal');

  { Data simulasi, bukan data jalan nyata. }
  AddEdge(1, 2, 2.0, 5, 2000);
  AddEdge(1, 3, 4.0, 8, 1000);
  AddEdge(2, 3, 1.5, 4, 1500);
  AddEdge(2, 4, 3.0, 7, 2500);
  AddEdge(3, 4, 2.0, 5, 1000);
  AddEdge(3, 5, 5.0, 10, 3000);
  AddEdge(4, 5, 2.5, 6, 1500);
end;

procedure ShowLocations;
var
  I: Integer;
begin
  Writeln;
  Writeln('=== DAFTAR LOKASI ===');

  for I := 1 to NodeCount do
    Writeln(I, '. ', Nodes[I].name);
end;

procedure ShowRoads;
var
  I: Integer;
begin
  Writeln;
  Writeln('=== DAFTAR JALAN ===');

  for I := 1 to EdgeCount do
  begin
    Write(I, '. ', Nodes[Edges[I].source].name,
      ' -> ', Nodes[Edges[I].destination].name);

    Write(' | ', Edges[I].distanceKm:0:1, ' km');
    Write(' | ', Edges[I].timeMinutes:0:0, ' menit');
    Write(' | Rp', Edges[I].costRupiah:0:0);

    if Edges[I].isOpen then
      Writeln(' | TERBUKA')
    else
      Writeln(' | DITUTUP');
  end;
end;

function GetWeight(EdgeIndex, Criterion: Integer): Real;
begin
  case Criterion of
    1: GetWeight := Edges[EdgeIndex].distanceKm;
    2: GetWeight := Edges[EdgeIndex].timeMinutes;
    3: GetWeight := Edges[EdgeIndex].costRupiah;
  else
    GetWeight := Edges[EdgeIndex].distanceKm;
  end;
end;

procedure FindRoute(StartNode, EndNode, Criterion: Integer);
var
  Dist: TRealArray;
  Previous: TIntArray;
  Visited: TBoolArray;
  Current, NextNode, I, J, PathLength: Integer;
  BestDistance, Weight: Real;
  Path: TIntArray;
begin
  if (StartNode < 1) or (StartNode > NodeCount) or
     (EndNode < 1) or (EndNode > NodeCount) then
  begin
    Writeln('ID lokasi tidak valid.');
    Exit;
  end;

  if (Criterion < 1) or (Criterion > 3) then
  begin
    Writeln('Kriteria tidak valid.');
    Exit;
  end;

  for I := 1 to NodeCount do
  begin
    Dist[I] := INF;
    Previous[I] := 0;
    Visited[I] := False;
  end;

  Dist[StartNode] := 0;

  { Algoritma Dijkstra }
  for I := 1 to NodeCount do
  begin
    Current := 0;
    BestDistance := INF;

    for J := 1 to NodeCount do
      if (not Visited[J]) and (Dist[J] < BestDistance) then
      begin
        BestDistance := Dist[J];
        Current := J;
      end;

    if (Current = 0) or (Current = EndNode) then
      Break;

    Visited[Current] := True;

    for J := 1 to EdgeCount do
    begin
      if not Edges[J].isOpen then
        Continue;

      NextNode := 0;

      if Edges[J].source = Current then
        NextNode := Edges[J].destination
      else if Edges[J].destination = Current then
        NextNode := Edges[J].source;

      if (NextNode = 0) or Visited[NextNode] then
        Continue;

      Weight := GetWeight(J, Criterion);

      if Dist[Current] + Weight < Dist[NextNode] then
      begin
        Dist[NextNode] := Dist[Current] + Weight;
        Previous[NextNode] := Current;
      end;
    end;
  end;

  if Dist[EndNode] >= INF then
  begin
    Writeln('Tidak ada rute yang tersedia.');
    Exit;
  end;

  { Rekonstruksi rute }
  PathLength := 0;
  Current := EndNode;

  while Current <> 0 do
  begin
    Inc(PathLength);
    Path[PathLength] := Current;

    if Current = StartNode then
      Break;

    Current := Previous[Current];
  end;

  if Path[PathLength] <> StartNode then
  begin
    Writeln('Rute tidak ditemukan.');
    Exit;
  end;

  Writeln;
  Writeln('=== HASIL PENCARIAN RUTE ===');

  for I := PathLength downto 1 do
  begin
    Write(Nodes[Path[I]].name);

    if I > 1 then
      Write(' -> ');
  end;

  Writeln;
  case Criterion of
    1: Writeln('Total jarak: ', Dist[EndNode]:0:2, ' km');
    2: Writeln('Estimasi waktu: ', Dist[EndNode]:0:2, ' menit');
    3: Writeln('Estimasi biaya: Rp', Dist[EndNode]:0:0);
  end;
end;

procedure ManageRoadStatus;
var
  I, Status: Integer;
begin
  ShowRoads;

  Write('Masukkan nomor jalan: ');
  Readln(I);

  if (I < 1) or (I > EdgeCount) then
  begin
    Writeln('Nomor jalan tidak valid.');
    Exit;
  end;

  Writeln('1. Tutup jalan');
  Writeln('2. Buka kembali jalan');
  Write('Pilihan: ');
  Readln(Status);

  case Status of
    1:
      begin
        Edges[I].isOpen := False;
        Writeln('Jalan berhasil ditutup.');
      end;
    2:
      begin
        Edges[I].isOpen := True;
        Writeln('Jalan berhasil dibuka kembali.');
      end;
  else
    Writeln('Pilihan tidak valid.');
  end;
end;

procedure RouteMenu;
var
  StartNode, EndNode, Criterion: Integer;
begin
  ShowLocations;

  Write('ID lokasi asal: ');
  Readln(StartNode);

  Write('ID lokasi tujuan: ');
  Readln(EndNode);

  Writeln;
  Writeln('Pilih kriteria optimasi:');
  Writeln('1. Jarak terpendek');
  Writeln('2. Waktu tercepat');
  Writeln('3. Biaya termurah');

  Write('Pilihan: ');
  Readln(Criterion);

  FindRoute(StartNode, EndNode, Criterion);
end;

procedure MainMenu;
var
  Choice: Integer;
begin
  repeat
    Writeln;
    Writeln('================================');
    Writeln(' PATHFINDER - ROUTE PLANNER');
    Writeln('================================');
    Writeln('1. Lihat daftar lokasi');
    Writeln('2. Lihat daftar jalan');
    Writeln('3. Cari rute optimal');
    Writeln('4. Tutup/buka jalan');
    Writeln('0. Keluar');
    Write('Pilihan: ');

    Readln(Choice);

    case Choice of
      1: ShowLocations;
      2: ShowRoads;
      3: RouteMenu;
      4: ManageRoadStatus;
      0: Writeln('Terima kasih telah menggunakan PATHFINDER.');
    else
      Writeln('Pilihan tidak valid.');
    end;
  until Choice = 0;
end;

begin
  InitializeData;
  MainMenu;
end.
