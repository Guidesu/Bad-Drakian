import { useState, useEffect } from 'react';
import { Button, Section, Stack, NoticeBox, Box, Tabs, Input } from 'tgui-core/components';
import { useBackend } from '../backend';
import { Window } from '../layouts';

type PaintingMeta = {
  id: string;
  title: string;
  author: string;
  author_ckey?: string;
  ic_date?: string;
  real_date?: string;
  round_id?: string;
};

type Data = {
  is_admin: boolean;
  my_ckey: string;
  paintings: PaintingMeta[];
  likes_map: Record<string, string[]>;
  deletion_logs?: string[];
};

export const ArtGallery = () => {
  const { act, data } = useBackend<Data>();
  const [loadedImages, setLoadedImages] = useState<Record<string, string>>({});
  const [selectedId, setSelectedId] = useState<string | null>(null);
  const [activeTab, setActiveTab] = useState<'gallery' | 'logs'>('gallery');

  const [searchQuery, setSearchQuery] = useState('');
  const [sortBy, setSortBy] = useState<'date' | 'alphabet' | 'likes'>('date');

  const customMessage = useBackend<any>().data?.image_data;

  useEffect(() => {
    if (customMessage?.id && customMessage?.base64) {
      if (!loadedImages[customMessage.id]) {
        setLoadedImages(prev => ({
          ...prev,
          [customMessage.id]: customMessage.base64
        }));
      }
    }
  }, [customMessage, loadedImages]);

  const requestImage = (id: string) => {
    setSelectedId(id);
    act('get_image', { id });
  };

  const handleDelete = (id: string) => {
    act('delete_painting', { id });
    setSelectedId(null);
  };

  const getLikesCount = (id: string) => {
    return data.likes_map?.[id]?.length || 0;
  };

  const hasLiked = (id: string) => {
    return data.likes_map?.[id]?.includes(data.my_ckey) || false;
  };

  const processedPaintings = [...(data.paintings || [])]
    .filter(p =>
      p.title.toLowerCase().includes(searchQuery.toLowerCase()) ||
      p.author.toLowerCase().includes(searchQuery.toLowerCase())
    )
    .sort((a, b) => {
      if (sortBy === 'alphabet') {
        return a.title.localeCompare(b.title);
      }
      if (sortBy === 'likes') {
        return getLikesCount(b.id) - getLikesCount(a.id);
      }

      const dateA = a.real_date || '';
      const dateB = b.real_date || '';
      return dateB.localeCompare(dateA);
    });

  return (
    <Window width={700} height={800} title="Server Art Gallery">
      <Window.Content scrollable>
        <Stack vertical fill>
          {data.is_admin && (
            <Stack.Item>
              <Tabs>
                <Tabs.Tab selected={activeTab === 'gallery'} onClick={() => setActiveTab('gallery')}>
                  Gallery
                </Tabs.Tab>
                <Tabs.Tab selected={activeTab === 'logs'} onClick={() => setActiveTab('logs')}>
                  Deletion logs({data.deletion_logs?.length || 0})
                </Tabs.Tab>
              </Tabs>
            </Stack.Item>
          )}

          {activeTab === 'gallery' && (
            <Stack.Item grow>
              <Stack fill>
                <Stack.Item width="220px">
                  <Section title="Search and Sort" fill scrollable>
                    <Input
                      fluid
                      placeholder="Search by name/author..."
                      value={searchQuery}
                      onChange={setSearchQuery}
                      style={{ marginBottom: '8px' }}
                    />

                    <Stack align="center" style={{ marginBottom: '12px' }}>
                      <Stack.Item>Sort by:</Stack.Item>
                      <Stack.Item>
                        <Button
                          icon="clock"
                          selected={sortBy === 'date'}
                          onClick={() => setSortBy('date')}
                          tooltip="Newest first"
                        />
                        <Button
                          icon="sort-alpha-down"
                          selected={sortBy === 'alphabet'}
                          onClick={() => setSortBy('alphabet')}
                          tooltip="Alphabetically"
                        />
                        <Button
                          icon="heart"
                          selected={sortBy === 'likes'}
                          onClick={() => setSortBy('likes')}
                          tooltip="By popularity"
                        />
                      </Stack.Item>
                    </Stack>

                    <Stack vertical mt={1}>
                      {processedPaintings.map(p => (
                        <Stack.Item key={p.id}>
                          <Button
                            fluid
                            selected={selectedId === p.id}
                            onClick={() => requestImage(p.id)}
                            style={{ textAlign: 'left' }}
                          >
                            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
                              <div>
                                <b>{p.title}</b> <br/>
                                <span style={{ fontSize: '10px', opacity: 0.7 }}>from{p.author}</span>
                              </div>
                              {getLikesCount(p.id) > 0 && (
                                <span style={{ color: '#e74c3c', fontSize: '11px' }}>
                                  ♥ {getLikesCount(p.id)}
                                </span>
                              )}
                            </div>
                          </Button>
                        </Stack.Item>
                      ))}
                    </Stack>
                  </Section>
                </Stack.Item>

                <Stack.Item grow>
                  <Section title="View" fill>
                    {selectedId ? (
                      <Stack vertical align="center">
                        <Stack.Item>
                          {loadedImages[selectedId] ? (
                            <div style={{
                              width: '256px',
                              height: '256px',
                              backgroundColor: '#f5e8d3',
                              border: '2px solid #333',
                              backgroundImage: `url(data:image/png;base64,${loadedImages[selectedId]})`,
                              backgroundSize: '100%',
                              imageRendering: 'pixelated'
                            }} />
                          ) : (
                            <Box>Loading canvas from archive...</Box>
                          )}
                        </Stack.Item>

                        <Stack.Item mt={2} textAlign="center">
                          <Box bold fontSize={2}>{data.paintings.find(p => p.id === selectedId)?.title}</Box>
                          <Box italic>Author:{data.paintings.find(p => p.id === selectedId)?.author}</Box>

                          <Box color="#f4cf5c" fontSize="15px" mt={0.5}>
                            Creation date:{data.paintings.find(p => p.id === selectedId)?.ic_date || 'Up to the Age of the New Order'}
                          </Box>

                          {data.is_admin && (
                            <>
                              <Box color="label" fontSize="15px" mt={0.5}>
                                Ckey by author:{data.paintings.find(p => p.id === selectedId)?.author_ckey || 'Unknown'}
                              </Box>
                              <Box color="label" fontSize="15px" mt={0.5}>
                                Created: {data.paintings.find(p => p.id === selectedId)?.real_date || 'Unknown'}
                              </Box>
                              <Box color="label" fontSize="15px" mt={0.5}>
                                Creation round:{data.paintings.find(p => p.id === selectedId)?.round_id || 'Unknown'}
                              </Box>
                            </>
                          )}
                        </Stack.Item>

                        <Stack.Item mt={3}>
                          <Stack align="center">
                            <Stack.Item>
                              <Button
                                icon="thumbs-up"
                                color={hasLiked(selectedId) ? 'good' : 'default'}
                                onClick={() => act('like_painting', { id: selectedId })}
                              >
                                {hasLiked(selectedId) ? 'Favorite painting!' : 'I like it'} ({getLikesCount(selectedId)})
                              </Button>
                            </Stack.Item>

                            {data.is_admin && (
                              <Stack.Item>
                                <Button.Confirm color="bad" icon="trash" onClick={() => handleDelete(selectedId)}>
                                  Delete
                                </Button.Confirm>
                              </Stack.Item>
                            )}
                          </Stack>
                        </Stack.Item>
                      </Stack>
                    ) : (
                      <Box italic textAlign="center" mt={10}>
                        Select a card from the list on the left.
                      </Box>
                    )}
                  </Section>
                </Stack.Item>
              </Stack>
            </Stack.Item>
          )}

          {activeTab === 'logs' && data.is_admin && (
            <Stack.Item grow>
              <Section title="Moderation logs" fill scrollable>
                {data.deletion_logs?.length === 0 ? (
                  <NoticeBox>Logs are empty. No cards were removed.</NoticeBox>
                ) : (
                  <Stack vertical>
                    {data.deletion_logs?.map((log, index) => (
                      <Stack.Item key={index}>
                        <Box style={{ fontFamily: 'monospace', borderBottom: '1px solid rgba(255,255,255,0.1)', padding: '6px 0', opacity: 0.9 }}>
                          {log}
                        </Box>
                      </Stack.Item>
                    ))}
                  </Stack>
                )}
              </Section>
            </Stack.Item>
          )}
        </Stack>
      </Window.Content>
    </Window>
  );
};
